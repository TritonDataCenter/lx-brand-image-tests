require 'spec_helper'

# Make sure Chef installs

describe command('curl -kL https://www.chef.io/chef/install.sh | bash') do
  its(:exit_status) { should eq 0 }
end

