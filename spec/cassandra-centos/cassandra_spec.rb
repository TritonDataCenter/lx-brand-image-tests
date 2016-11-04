# NOTE: This test suite will only work for lx image with CentOS 6 or 7 operating system.

require 'spec_helper'

$runtest = ENV["TEST"]
$IP1 = ENV["NODE1"]
$IP2 = ENV["NODE2"]
$RCOUNT = ENV["RC"]
$OCOUNT = ENV["OC"]
$THREAD = ENV["TH"]

case $runtest
# ------------------------------------------------------------------
# Test Set A: Install and configure Cassandra software on each node of the cluster.
#
when "A1", "A2"

# Install OpenJDK 8
describe command('yum -y install java-1.8.0-openjdk-devel') do
  its(:exit_status) { should eq 0 }
end

# Check version of Java
describe command('java -version 2>&1 | grep -i version') do
  its(:stdout) { should contain('1.8.0') }
end

# Install Python 2.7 for CentOS 7
if os[:release].to_i == 7
  describe command('yum -y install python') do
     its(:exit_status) { should eq 0 }
  end
  describe command('python -V 2>&1') do
    its(:stdout) { should contain('2.7') }
  end
end

# Install Python 2.7 for CentOS 6
if os[:release].to_i == 6
  describe command('yum -y install scl-utils && yum -y install centos-release-scl-rh && yum -y install python27') do
    its(:exit_status) { should eq 0 }
  end
  describe command('source /opt/rh/python27/enable && python -V 2>&1') do
    its(:stdout) { should contain('2.7') }
  end
end

$FIREWALLCMD = "systemctl stop firewalld && systemctl disable firewalld" if os[:release].to_i == 7 
$FIREWALLCMD = "if [ -e /etc/init.d/iptables ]; then service iptables save; service iptables stop; chkconfig iptables off; fi" if os[:release].to_i == 6 

# Disable the firewall
describe command($FIREWALLCMD) do
  its(:exit_status) { should eq 0 }
end

# Add yum repo for Datastax software
describe command('printf "[datastax-ddc]\nname = DataStax Repo for Apache Cassandra\nbaseurl = http://rpm.datastax.com/datastax-ddc/3.9\nenabled = 1\ngpgcheck = 0\n" > /etc/yum.repos.d/datastax.repo') do
  its(:exit_status) { should eq 0 }
end

# Install the Datastax-distributed version of Cassandra software
describe command('yum -y install datastax-ddc') do
  its(:exit_status) { should eq 0 }
end

# Check version of Cassandra
describe command('/usr/sbin/cassandra -v') do
  its(:stdout) { should contain('3.9') }
end

# Make multiple modifications to cassandra.yaml

describe command('cd /etc/cassandra/conf && sed -i "s/^cluster_name: .*/cluster_name: TestCluster/" cassandra.yaml && sed -i "s/^num_tokens: .*/num_tokens: 256/" cassandra.yaml && sed -i "s/^endpoint_snitch: .*/endpoint_snitch: GossipingPropertyFileSnitch/" cassandra.yaml && echo "auto_bootstrap: false" >> cassandra.yaml && echo "disk_access_mode: standard" >> cassandra.yaml') do
  its(:exit_status) { should eq 0 }
end

if $runtest == "A1"
   $IPCMD = "cd /etc/cassandra/conf && sed -i 's/^listen_address: .*/listen_address: " + $IP1 + "/' cassandra.yaml && sed -i 's/^rpc_address: .*/rpc_address: 0.0.0.0/' cassandra.yaml && sed -i 's/# broadcast_rpc_address: .*/broadcast_rpc_address: " + $IP1 + "/' cassandra.yaml && sed -i 's/seeds: .*/seeds: " + $IP1 + "/' cassandra.yaml"
elsif $runtest == "A2"
   $IPCMD = "cd /etc/cassandra/conf && sed -i 's/^listen_address: .*/listen_address: " + $IP2 + "/' cassandra.yaml && sed -i 's/^rpc_address: .*/rpc_address: 0.0.0.0/' cassandra.yaml && sed -i 's/# broadcast_rpc_address: .*/broadcast_rpc_address: " + $IP2 + "/' cassandra.yaml && sed -i 's/seeds: .*/seeds: " + $IP1 + "/' cassandra.yaml"
end

describe command($IPCMD) do
  its(:exit_status) { should eq 0 }
end

describe command('cd /etc/cassandra/conf && sed -i "s/^read_request_timeout_in_ms: .*/read_request_timeout_in_ms: 30000/" cassandra.yaml && sed -i "s/^range_request_timeout_in_ms: .*/range_request_timeout_in_ms: 30000/" cassandra.yaml && sed -i "s/^write_request_timeout_in_ms: .*/write_request_timeout_in_ms: 30000/" cassandra.yaml && sed -i "s/^counter_write_request_timeout_in_ms: .*/counter_write_request_timeout_in_ms: 30000/" cassandra.yaml && sed -i "s/^cas_contention_timeout_in_ms: .*/cas_contention_timeout_in_ms: 10000/" cassandra.yaml && sed -i "s/^truncate_request_timeout_in_ms: .*/truncate_request_timeout_in_ms: 60000/" cassandra.yaml && sed -i "s/^request_timeout_in_ms: .*/request_timeout_in_ms: 10000/" cassandra.yaml') do
  its(:exit_status) { should eq 0 }
end

# Create cassandra-rackdc.properties
describe command('printf "dc=DC1\nrack=RAC1\n" > /etc/cassandra/conf/cassandra-rackdc.properties') do
  its(:exit_status) { should eq 0 }
end

# Remove the default cluster_name
describe command('rm -rf /var/lib/cassandra/data/system/*') do
  its(:exit_status) { should eq 0 }
end

# Modify /etc/init.d/cassandra
describe command('sed -i "/echo -n \"Starting Cassandra: \"/amkdir -p \/var\/run\/cassandra\nchown cassandra:cassandra \/var\/run\/cassandra" /etc/init.d/cassandra') do
  its(:exit_status) { should eq 0 }
end

# Register cassandra service
describe command('chkconfig --add cassandra && chkconfig cassandra on') do
  its(:exit_status) { should eq 0 }
end

# Verify that the cassandra service is enabled
describe service('cassandra') do
  it { should be_enabled }
end

# Start the cassandra service
describe command('service cassandra start') do
  its(:exit_status) { should eq 0 }
end

# Verify that the cassandra service is running
describe service('cassandra') do
  it { should be_running }
end

# ------------------------------------------------------------------
# Test Set B: Verify if Cassandra cluster is really up.
#
when "B"

# Check the status of Cassandra cluster
describe command("nodetool status | awk '/^(U|D)(N|L|J|M)/{print $1 $2}' > /tmp/nodetool.out && nodetool describecluster >> /tmp/nodetool.out") do
  its(:exit_status) { should eq 0 }
end

# Verify that both Cassandra nodes are running and reachable
describe file('/tmp/nodetool.out') do
  it { should contain 'UN'+$IP1 }
  it { should contain 'UN'+$IP2 }
  it { should contain 'TestCluster' }
  it { should_not contain 'UNREACHABLE:' }
end

# Create the "ycsb" keyspace

describe command('printf "create keyspace ycsb WITH REPLICATION = {\'class\' : \'SimpleStrategy\', \'replication_factor\': 3 };\nuse ycsb;\ncreate table usertable (y_id varchar primary key, field0 varchar, field1 varchar, field2 varchar, field3 varchar, field4 varchar, field5 varchar, field6 varchar, field7 varchar, field8 varchar, field9 varchar);" > /tmp/ycsb-ks.cql') do
  its(:exit_status) { should eq 0 }
end

sleep 5

if os[:release].to_i == 7
  describe command('cqlsh 127.0.0.1 -f /tmp/ycsb-ks.cql') do
    its(:exit_status) { should eq 0 }
  end
end

if os[:release].to_i == 6
  describe command('sed -i "/from uuid import UUID/asys.path.append(\"/usr/lib/python2.7/site-packages\")" /usr/bin/cqlsh.py') do
    its(:exit_status) { should eq 0 }
  end
  describe command('source /opt/rh/python27/enable && cqlsh 127.0.0.1 -f /tmp/ycsb-ks.cql') do
    its(:exit_status) { should eq 0 }
  end
end

# ------------------------------------------------------------------
# Test Set C: Install and configure the YCSB benchmark test tool.
#
when "C"

# Install OpenJDK 8
describe command('yum -y install java-1.8.0-openjdk-devel') do
  its(:exit_status) { should eq 0 }
end

# Check version of Java
describe command('java -version 2>&1 | grep -i version') do
  its(:stdout) { should contain('1.8.0') }
end

$FIREWALLCMD = "systemctl stop firewalld && systemctl disable firewalld" if os[:release].to_i == 7 
$FIREWALLCMD = "if [ -e /etc/init.d/iptables ]; then service iptables save; service iptables stop; chkconfig iptables off; fi" if os[:release].to_i == 6 

# Disable the firewall
describe command($FIREWALLCMD) do
  its(:exit_status) { should eq 0 }
end

# Install YCSB tool
describe command('cd /opt && wget --no-check-certificate https://github.com/brianfrankcooper/YCSB/releases/download/0.11.0/ycsb-0.11.0.tar.gz && tar xfvz ycsb-0.11.0.tar.gz && cd /opt/ycsb-0.11.0 && mkdir LOG') do
  its(:exit_status) { should eq 0 }
end

# ------------------------------------------------------------------
# Test Set D: Load the YCSB "workloada" set of test data.
#
when "D"

$LOADCMD = "cd /opt/ycsb-0.11.0 && bin/ycsb load cassandra-cql -P workloads/workloada -p recordcount=" + $RCOUNT + " -p hosts='" + $IP1 + "," + $IP2 + "' -threads " + $THREAD + " -s > LOG/workloada_load.out 2> LOG/load.log"

describe command($LOADCMD) do
  its(:exit_status) { should eq 0 }
end

# ------------------------------------------------------------------
# Test Set E: Run the YCSB "workloada" benchmark tests.
#
when "E"

$RUNCMD = "cd /opt/ycsb-0.11.0 && bin/ycsb run cassandra-cql -P workloads/workloada -p recordcount=" + $RCOUNT + " -p hosts='" + $IP1 + "," + $IP2 + "' -p operationcount=" + $OCOUNT + " -threads " + $THREAD + " -s > LOG/workloada_run.out 2> LOG/run.log"

describe command($RUNCMD) do
  its(:exit_status) { should eq 0 }
end

# ---------------------------------------
# End of tests
#
end
