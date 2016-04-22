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

# Make sure we apt pin udev in Ubuntu 16.XX and 17.XX
if property[:name] =~ /Ubuntu 16./
  describe file('/etc/apt/preferences.d/udev') do
    it { should be_file }
    its(:content) { should match /Package: udev/ }
    its(:content) { should match /Pin: release */ }
    its(:content) { should match /Pin-Priority: -1/ }
  end
end

if property[:name] =~ /Ubuntu 17./
  describe file('/etc/apt/preferences.d/udev') do
    it { should be_file }
    its(:content) { should match /Package: udev/ }
    its(:content) { should match /Pin: release */ }
    its(:content) { should match /Pin-Priority: -1/ }
  end
end
