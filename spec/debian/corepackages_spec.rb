require 'spec_helper'

describe package('ca-certificates') do
  it { should be_installed }
end

describe package('cron') do
  it { should be_installed }
end

describe package('iproute') do
  it { should be_installed }
end

describe package('net-tools') do
  it { should be_installed }
end

describe package('openssh-server') do
  it { should be_installed }
end

describe package('python-software-properties') do
  it { should be_installed }
end

describe package('rsyslog') do
  it { should be_installed }
end

describe package('software-properties-common') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end
