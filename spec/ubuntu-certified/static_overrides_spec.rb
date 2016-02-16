require 'spec_helper'

## Static overrides included in the image

describe file('/etc/init/console.override') do
	it { should be_file }
	its(:md5sum) { should eq '7ee0e4d8968d264ef99275a50e9cff20' }
end

describe file('/etc/init/container-detect.override') do
	it { should be_file }
	its(:md5sum) { should eq 'dfd990f3a6ed9ed8582a3bae564551d9' }
end

describe file('/etc/init/mountall.override') do
	it { should be_file }
	its(:md5sum) { should eq '77e43ed540b051c9dc22df649eb7b597' }
end
