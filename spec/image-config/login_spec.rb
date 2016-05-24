require 'spec_helper'

# Make sure ssh login is via ssh key only.
describe file('/etc/ssh/sshd_config') do
  it { should be_file }
  its(:content) { should match /^PasswordAuthentication no/ }
end
