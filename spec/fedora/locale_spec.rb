require 'spec_helper'

# Ensure locale is set to en_US.UTF-8.
describe file('/etc/locale.conf') do
it { should be_file }
its(:content) { should match /LANG="en_US.UTF-8"/ }
end
