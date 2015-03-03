require 'spec_helper'

# Since 20140106. See IMAGE-440. Addresses IMAGE-400.
# Certified Ubuntu images missing mdata-get, etc
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

describe file('/lib/smartdc/mdata-get') do
	it { should be_file }
	it { should be_linked_to '/usr/sbin/mdata-get' }
end

