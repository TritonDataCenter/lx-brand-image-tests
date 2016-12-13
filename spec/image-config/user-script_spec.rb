require 'spec_helper'

# This test requires that you are provisioning a VM with user-script 
# that contains:
#
# #!/bin/sh
# echo "testing user-script" >> /var/tmp/test
describe file('/var/svc/mdata-user-script') do
	it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_executable }
  its(:content) { should match /#!\/usr\/bin\/env bash/ }
  its(:content) { should match /set -x/ } 
  its(:content) { should match /echo "testing user-script" >> \/var\/tmp\/test/ }
end

# The test user-script (see above) should create the file /var/tmp/test
# with the contents "testing user-script".
describe file('/var/tmp/test') do
  it { should be_file }
  its(:content) { should match /testing user-script/ }
end
