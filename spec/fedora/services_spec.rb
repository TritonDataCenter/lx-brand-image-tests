require 'spec_helper'

describe service('crond') do
  it { should be_enabled }
  it { should be_running }
end

describe service('chronyd') do
  it { should be_enabled }
  it { should be_running }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end

describe service('sshd') do
  it { should be_enabled }
end

describe service('timedatex') do
  it { should be_enabled }
  it { should be_running }
end

