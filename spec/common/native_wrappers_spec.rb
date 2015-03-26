require 'spec_helper'

# Test for wrappers for binaries in /usr/bin/

describe file('/usr/bin/arcstat') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_executable }
end

describe file('/usr/bin/sysinfo') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_executable }
end

describe file('/usr/bin/vfsstat') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_executable }
end

# Test for wrappers for binaries in /usr/sbin/

describe file('/usr/sbin/zonememstat') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_executable }
end
