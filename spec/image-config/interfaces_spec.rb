require 'spec_helper'

# This test requires a VM to be provision with two IPs, preferably one public
# and one private.

# Test to ensure the VM has two interfaces, eth0 and eth1

# eth0
describe interface('eth0') do
  it { should exist }
end

describe command('ifconfig eth0 | grep UP | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

# eth1
describe interface('eth1') do
  it { should exist }
end

describe command('ifconfig eth1 | grep UP | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

# check for loopback interface
describe command('ifconfig lo | grep UP | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

# Test to ensure there is a route for both interfaces
# and the primary interface as default gateway

describe command('netstat -r | grep default | grep eth0 | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

describe command('netstat -r | grep eth1 | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end
