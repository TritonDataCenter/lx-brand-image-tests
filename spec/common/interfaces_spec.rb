require 'spec_helper'

# This test requires a VM to be provision with two IPs, preferably one public
# and one private.

# Test to ensure the VM has two interfaces, eth0 and eth1

# eth0
describe interface('eth0') do
  it { should exist }
end

describe interface('eth0') do
  it { should be_up }
end

# eth1
describe interface('eth1') do
  it { should exist }
end

describe interface('eth1') do
  it { should be_up }
end