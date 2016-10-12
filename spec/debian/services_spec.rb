require 'spec_helper'

describe service('cron') do
  it { should be_enabled }
  it { should be_running }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end

describe service('ssh') do
  it { should be_enabled }
  it { should be_running }
end

