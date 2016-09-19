require 'spec_helper'

# Testing basic yum commands
describe command('dnf -y update') do
  its(:exit_status) { should eq 0 }
end

describe command('dnf -y install nano') do
  its(:exit_status) { should eq 0 }
end

describe command('dnf -y erase nano') do
  its(:exit_status) { should eq 0 }
end
