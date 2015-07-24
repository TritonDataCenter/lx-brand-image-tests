require 'spec_helper'

describe file('/etc/init/ttyS0.conf') do
	it { should be_file }
  its(:sha256sum) { should eq '539050f264117743450c0fbbca4c7efe632a054d0e279fd1fa879b2ba6d1d589' }
end

