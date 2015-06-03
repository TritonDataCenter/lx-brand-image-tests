require 'spec_helper'

describe file('/etc/man.conf') do
	it { should be_file }
	it { should contain "MANPATH /native/usr/share/man" }
end
