require 'spec_helper'

describe service('cron') do
  it { should be_enabled }
end

describe service('sshd') do
  it { should be_enabled }
end

