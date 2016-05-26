require 'spec_helper'

# Systemd overrides for CentOS 7+, Debian 8+ and Ubuntu 16.04+
# See:
#   - https://github.com/joyent/centos-lx-brand-image-builder/issues/5
#   - https://github.com/joyent/centos-lx-brand-image-builder/issues/7
#   - https://smartos.org/bugview/OS-5304

# TODO: Move the command tests to common-lx?


describe file('/etc/systemd/system/systemd-hostnamed.service.d/override.conf') do
  if file('/usr/bin/hostnamectl').exists?
    it { should be_file }
    its(:content) { should match /[Service]/ }
    its(:content) { should match /PrivateTmp=no/ }
    its(:content) { should match /PrivateDevices=no/ }
    its(:content) { should match /PrivateNetwork=no/ }
    its(:content) { should match /ProtectSystem=no/ }
    its(:content) { should match /ProtectHome=no/ }
  end
end

describe command('hostnamectl') do
  if file('/usr/bin/hostnamectl').exists?
    its(:exit_status) { should eq 0 }
  end
end

describe file('/etc/systemd/system/systemd-localed.service.d/override.conf') do
  if file('/usr/bin/localectl').exists?
    it { should be_file }
    its(:content) { should match /[Service]/ }
    its(:content) { should match /PrivateTmp=no/ }
    its(:content) { should match /PrivateDevices=no/ }
    its(:content) { should match /PrivateNetwork=no/ }
    its(:content) { should match /ProtectSystem=no/ }
    its(:content) { should match /ProtectHome=no/ }
  end
end

describe command('localectl') do
  if file('/usr/bin/localectl').exists?
    its(:exit_status) { should eq 0 }
  end
end

describe file('/etc/systemd/system/systemd-timedated.service.d/override.conf') do
  if file('/usr/bin/timedatectl').exists?
    it { should be_file }
    its(:content) { should match /[Service]/ }
    its(:content) { should match /PrivateTmp=no/ }
    its(:content) { should match /PrivateDevices=no/ }
    its(:content) { should match /PrivateNetwork=no/ }
    its(:content) { should match /ProtectSystem=no/ }
    its(:content) { should match /ProtectHome=no/ }
  end
end

describe command('timedatectl') do
  if file('/usr/bin/timedatectl').exists?
    its(:exit_status) { should eq 0 }
  end
end
