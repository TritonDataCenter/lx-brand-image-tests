require 'spec_helper'

# Ensure the hostid value is unique. See IMAGE-462.
# https://bugs.launchpad.net/orinda/+bug/1284713
describe command('hostid') do
  its(:stdout) { should_not match "00000000" }
end

