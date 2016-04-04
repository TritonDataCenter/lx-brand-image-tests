require 'spec_helper'

# No root password should be set

# Test for "*/n" or "/n" 
describe command("cat /etc/shadow | grep root | awk -F':' '{print $2;}'") do
  its(:stdout) { should match /\*?\n/ }
end


# Need to fix the test somehow.
# This will grep for ! * and and emty entry for root:
#  sudo cat /etc/shadow | grep root| grep '^[^:]*:.\?:' 

