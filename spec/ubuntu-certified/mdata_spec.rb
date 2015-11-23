require 'spec_helper'

# Test for mdata-* tools symlinks

describe file('/usr/sbin/mdata-get') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-get' }
  it { should be_mode 777 }
end

describe file('/usr/sbin/mdata-list') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-list' }
  it { should be_mode 777 }
end

describe file('/usr/sbin/mdata-put') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-put' }
  it { should be_mode 777 }
end

describe file('/usr/sbin/mdata-delete') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-delete' }
  it { should be_mode 777 }
end

# Test mdata-* commands

describe command('mdata-put test test') do
  its(:exit_status) { should eq 0 }
end

describe command('mdata-get test') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /test/ }
end

describe command('mdata-list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /test/ }
end

describe command('mdata-delete test') do
  its(:exit_status) { should eq 0 }
end

describe command('mdata-get test') do
  its(:exit_status) { should eq 1 }
  its(:stderr) { should match /No metadata for 'test'/ }
end

describe command('mdata-list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should_not match /test/ }
end