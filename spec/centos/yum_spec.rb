require 'spec_helper'

# Testing basic yum commands
describe command('yum -y update') do
  its(:exit_status) { should eq 0 }
end

describe command('yum -y install nano') do
  its(:exit_status) { should eq 0 }
end

describe command('yum -y erase nano') do
  its(:exit_status) { should eq 0 }
end
