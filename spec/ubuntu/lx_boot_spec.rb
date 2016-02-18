require 'spec_helper'

# Testing for override files created by lx_boot

# See https://github.com/joyent/illumos-joyent/blob/master/usr/src/lib/brand/lx/zone/lx_boot_zone_ubuntu.ksh

## Dynamic overrides. Typically these are for network and DNS

# DNS Resolvers
describe file('/etc/resolvconf/resolv.conf.d/tail') do
	it { should be_file }
	it { should contain "# AUTOMATIC ZONE CONFIG" }
end

# Network interfaces
# describe file('/etc/network/interfaces.d/smartos') do
# 	it { should be_file }
# 	it { should contain "# AUTOMATIC ZONE CONFIG" }
# end

## Static overrides

describe file('/etc/init/console.override') do
	it { should be_file }
	its(:md5sum) { should eq '7ee0e4d8968d264ef99275a50e9cff20' }
end

describe file('/etc/init/container-detect.override') do
	it { should be_file }
	its(:md5sum) { should eq 'dfd990f3a6ed9ed8582a3bae564551d9' }
end

describe file('/etc/init/mountall.override') do
	it { should be_file }
	its(:md5sum) { should eq '77e43ed540b051c9dc22df649eb7b597' }
end
