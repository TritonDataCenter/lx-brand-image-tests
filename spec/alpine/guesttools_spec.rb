require 'spec_helper'

describe file('/etc/local.d/joyent.start') do
	it { should be_file }
	it { should be_executable }
end
