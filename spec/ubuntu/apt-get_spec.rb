require 'spec_helper'

# Testing basic apt-get commands
describe command('apt-get -y update') do
  its(:exit_status) { should eq 0 }
end

describe command('apt-get -y upgrade') do
  its(:exit_status) { should eq 0 }
end

describe command('apt-get -y install apg') do
  its(:exit_status) { should eq 0 }
end

describe command('apt-get -y remove apg') do
  its(:exit_status) { should eq 0 }
end
