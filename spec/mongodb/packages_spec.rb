require 'spec_helper'

describe package('mongodb-org') do
  it { should be_installed }
end

describe command('mongod --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /v3\.4\.*/ }
end
