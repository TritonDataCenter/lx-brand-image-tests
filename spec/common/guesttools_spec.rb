require 'spec_helper'

describe file('/usr/sbin/mdata-get') do
  it { should be_file }
	it { should be_mode 755 }
end

describe file('/usr/sbin/mdata-list') do
  it { should be_file }
  it { should be_mode 755 }
end

describe file('/usr/sbin/mdata-put') do
  it { should be_file }
  it { should be_mode 755 }
end

describe file('/usr/sbin/mdata-delete') do
  it { should be_file }
  it { should be_mode 755 }
end
