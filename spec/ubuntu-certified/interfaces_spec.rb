require 'spec_helper'

# This test requires a VM to be provision with two IPs, preferably one public
# and one private.

# TODO: This will need to be updated for 16.04
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