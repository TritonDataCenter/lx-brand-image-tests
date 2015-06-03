require 'spec_helper'

# No root password should be set

if property[:name].include? "Alpine"
  # An alternate test for Alpine Linux. The value will be ''
  describe command("cat /etc/shadow | grep root | awk -F':' '{print $2;}'") do
    its(:stdout) { should eq "\n" }
  end
else
  # Test for "*" for everything else
  describe command("cat /etc/shadow | grep root | awk -F':' '{print $2;}'") do
    its(:stdout) { should eq "*\n" }
  end
end



