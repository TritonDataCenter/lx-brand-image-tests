require 'spec_helper'

# Ensure locale is set to en_US.UTF-8. See IMAGE-889

if property[:name].include? "CentOS 6"
  describe file('/etc/sysconfig/i18n') do
    it { should be_file }
    its(:content) { should match /LANG="en_US.UTF-8"/ }
  end
else
  describe file('/etc/locale.conf') do
    it { should be_file }
    its(:content) { should match /LANG="en_US.UTF-8"/ }
  end
end

