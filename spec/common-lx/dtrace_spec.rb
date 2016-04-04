require 'spec_helper'

# Test DTrace commmands

# Print version
describe command('/native/usr/sbin/dtrace -V') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('dtrace: Sun D ') }
end

# List all probes
describe command('/native/usr/sbin/dtrace -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('PROVIDER') }
end

# List all probes provided by the syscall provider
describe command('/native/usr/sbin/dtrace -l -P syscall') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('PROVIDER') }
end

# Print all entry probes provided by the syscall provide
describe command('/native/usr/sbin/dtrace -l -n syscall:::entry') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain('PROVIDER') }
end