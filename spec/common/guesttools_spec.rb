require 'spec_helper'

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
