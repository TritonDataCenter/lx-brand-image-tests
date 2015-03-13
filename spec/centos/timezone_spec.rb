require 'spec_helper'

describe file('/etc/localtime') do
	it { should be_file }
  its(:content) { should match /UTC/ }
end
