require 'spec_helper'

# Test group add/delete actions
# Also check the presence of sudoer groups

# Don't run tests on Alpine
# TODO: Add tests for Alpine Linux :)
if ! file('/etc/alpine-release').exists?
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

  if file('/etc/debian_version').exists?
    describe group('sudo') do
      it { should exist }
    end
  elsif file('/etc/centos-release').exists?
    describe group('wheel') do
      it { should exist }
    end
  end
end
