require 'spec_helper'

# Systemd overrides

# httpd.service
#
# See:
#   - IMAGE-926
#   - https://smartos.org/bugview/OS-5304

describe "httpd service validation" do
  describe "Systemd override for httpd shoud be valid" do
    describe file('/etc/systemd/system/httpd.service.d/override.conf') do
      it { should be_file }
      its(:content) { should match /[Service]/ }
      its(:content) { should match /PrivateTmp=no/ }
    end
  end

  describe "Install of httpd package should succeed" do
    describe command('dnf -y install httpd') do
      its(:exit_status) { should eq 0 }
    end
    describe command('systemctl restart httpd') do
      its(:exit_status) { should eq 0 }
    end
  end

  describe service('httpd') do
    it { should be_running }
  end

  describe command('dnf -y erase httpd') do
    its(:exit_status) { should eq 0 }
  end

  describe command('systemctl daemon-reload') do
    its(:exit_status) { should eq 0 }
  end
end
