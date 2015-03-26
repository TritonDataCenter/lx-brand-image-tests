require 'spec_helper'

# Test for symlinks for binaries in /native/usr/sbin/

describe file('/usr/sbin/cpustat') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/cpustat' }
end
  
describe file('/usr/sbin/dtrace') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/dtrace' }
end
  
describe file('/usr/sbin/mdata-get') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/mdata-get' }
end

describe file('/usr/sbin/mdata-list') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-list' }
end

describe file('/usr/sbin/mdata-put') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-put' }
end

describe file('/usr/sbin/mdata-delete') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-delete' }
end

describe file('/usr/sbin/plockstat') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/plockstat' }
end

