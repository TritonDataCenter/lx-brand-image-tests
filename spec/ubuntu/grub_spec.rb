require 'spec_helper'

describe file('/etc/default/grub.d/50-cloudimg-settings.cfg') do
	it { should be_file }
	it { should contain "GRUB_CMDLINE_LINUX_DEFAULT=\"tsc=reliable earlyprintk\"" }
  it { should contain "GRUB_TIMEOUT=5" }
end


