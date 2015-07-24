require 'spec_helper'

describe file('/etc/profile.d/native_manpath.sh') do
	it { should be_file }
	it { should contain "export MANPATH=$MANPATH:/native/usr/share/man" }
end
