require 'spec_helper'

# Test for mdata-* tools symlinks

describe file('/usr/sbin/mdata-get') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-get' }
  it { should be_executable }
end

describe file('/usr/sbin/mdata-list') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-list' }
  it { should be_executable }
end

describe file('/usr/sbin/mdata-put') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-put' }
  it { should be_executable }
end

describe file('/usr/sbin/mdata-delete') do
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-delete' }
  it { should be_executable }
end
