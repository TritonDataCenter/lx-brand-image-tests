require 'spec_helper'

# Testing basic apk commands
describe command('apk update') do
  its(:exit_status) { should eq 0 }
end

describe command('apk upgrade') do
  its(:exit_status) { should eq 0 }
end

describe command('apk add apg') do
  its(:exit_status) { should eq 0 }
end

describe command('apk del apg') do
  its(:exit_status) { should eq 0 }
end
