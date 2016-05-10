require 'spec_helper'

# Test various systemd commands

# We should be teting a variety of systemd commands to ensure they work
# The hostnamectl and timedatectl commands will fail partly because of:
# https://smartos.org/bugview/OS-5304

# Note that as a workaround images from 20160505 have overrides in place for
# the systemd-hostnamed and systemd-timedated services.

describe command('hostnamectl') do
  if file('/usr/bin/hostnamectl').exists?
    its(:exit_status) { should eq 0 }
  end
end

describe command('timedatectl') do
  if file('/usr/bin/timedatectl').exists?
    its(:exit_status) { should eq 0 }
  end
end