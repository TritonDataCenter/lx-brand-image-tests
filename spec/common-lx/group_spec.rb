require 'spec_helper'

# Test group add/delete actions
# Also check the presence of sudoer groups

# Bail if OS is Alpine Linux
# TODO: Add tests for Alpine Linux :)
if file('/etc/alpine-release').exists?
  exit
end

describe command('groupadd foo') do
  its(:exit_status) { should equal 0 }
end

describe group('foo') do
  it { should exist }
end

describe command('usermod -a -G foo root') do
  its(:exit_status) { should eq 0 }
end

describe user('root') do
  it { should belong_to_group 'foo' }
end

describe command('groupdel foo') do
  its(:exit_status) { should eq 0 }
end

describe group('foo') do
  it { should_not exist }
end

if property[:name] =~ /Ubuntu/ or property[:name] =~ /Debian/
  describe group('sudo') do
    it { should exist }
  end
elsif property[:name] =~ /CentOS/
  describe group('wheel') do
    it { should exist }
  end
end
