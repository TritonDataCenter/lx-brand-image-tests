require 'spec_helper'

describe command('mkdir /home/bar') do
  its(:exit_status) { should eq 0 }
end

describe command('useradd bar -g wheel -d /home/bar') do
  its(:exit_status) { should eq 0 }
end

describe user('bar') do
  it { should exist }
  it { should belong_to_group 'wheel' }
  it { should have_home_directory '/home/bar' }
end

describe command('echo "bar:joypass123" | chpasswd') do
  its(:exit_status) { should eq 0 }
end

describe command('mkdir /opt/bar') do
  its(:exit_status) { should eq 0 }
end

describe command('touch /opt/bar/test.sh') do
  its(:exit_status) { should eq 0 }
end

describe command('chown -R bar /opt/bar') do
  its(:exit_status) { should eq 0 }
end

describe file('/opt/bar/test.sh') do
  it { should exist }
  it { should be_writable.by_user('bar') }
end

describe command('rm -Rf /opt/bar && rm -Rf /home/bar') do
  its(:exit_status) { should eq 0 }
end

describe command('userdel bar') do
  its(:exit_status) { should eq 0 }
end

describe user('bar') do
  it { should_not exist }
end
