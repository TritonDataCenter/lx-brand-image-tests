require 'spec_helper'

# No root password should be set

# Test for "*/n" or "/n" 
describe command("cat /etc/shadow | grep root | awk -F':' '{print $2;}'") do
  its(:stdout) { should match /\*?\n/ }
end




