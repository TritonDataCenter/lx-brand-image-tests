require 'spec_helper'

# Make sure Chef installs

if ! file('/etc/alpine-release').exists?
  describe command('curl -kL https://www.chef.io/chef/install.sh | bash') do
    its(:exit_status) { should eq 0 }
  end
end
