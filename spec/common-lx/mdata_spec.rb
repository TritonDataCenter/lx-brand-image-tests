require 'spec_helper'

# Test mdata-* commands

describe command('/native/usr/sbin/mdata-put test test') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/mdata-get test') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /test/ }
end

describe command('/native/usr/sbin/mdata-list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /test/ }
end

describe command('/native/usr/sbin/mdata-delete test') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/mdata-get test') do
  its(:exit_status) { should eq 1 }
  its(:stderr) { should match /No metadata for 'test'/ }
end

describe command('/native/usr/sbin/mdata-list') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should_not match /test/ }
end
