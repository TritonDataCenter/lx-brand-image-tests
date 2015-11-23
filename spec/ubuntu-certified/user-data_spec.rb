require 'spec_helper'

# This test requires that you are provisioning an instance with user-data
# string "This is user-data!"
describe file('/var/db/mdata-user-data') do
  it { should be_file }
  it { should_not be_executable }
  it { should be_owned_by 'root' }
  its(:content) { should match /This is user-data!/ }
end