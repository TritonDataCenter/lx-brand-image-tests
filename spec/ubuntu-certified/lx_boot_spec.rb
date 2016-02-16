require 'spec_helper'

# Testing for dynamic override files created by lx_boot
# Typically these are for network and DNS

# See https://github.com/joyent/illumos-joyent/blob/master/usr/src/lib/brand/lx/zone/lx_boot_zone_ubuntu.ksh

# DNS Resolvers
describe file('/etc/resolvconf/resolv.conf.d/tail') do
	it { should be_file }
	it { should contain "# AUTOMATIC ZONE CONFIG" }
end

# Network interfaces
describe file('/etc/network/interfaces.d/smartos') do
	it { should be_file }
	it { should contain "# AUTOMATIC ZONE CONFIG" }
end