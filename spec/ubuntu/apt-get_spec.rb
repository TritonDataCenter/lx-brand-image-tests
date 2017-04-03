require 'spec_helper'

# Make sure we apt pin makedev
describe file('/etc/apt/preferences.d/makedev') do
  it { should be_file }
  its(:content) { should match /Package: makedev/ }
  its(:content) { should match /Pin: release */ }
  its(:content) { should match /Pin-Priority: -1/ }
end

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
