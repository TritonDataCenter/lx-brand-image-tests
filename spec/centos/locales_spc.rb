require 'spec_helper'

# Ensure locale is properly set. See IMAGE-889
if property[:name] =~ /CentOS 7./
  describe file('/etc/locale.conf') do
    it { should be_file }
    it { should contain "LANG=\"en_US.UTF-8\"" }
  end
end

if property[:name] =~ /CentOS 6./
  describe file('/etc/sysconfig/i18n') do
    it { should be_file }
    it { should contain "LANG=\"en_US.UTF-8\"" }
  end
end
