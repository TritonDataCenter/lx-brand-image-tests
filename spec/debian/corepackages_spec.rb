require 'spec_helper'

describe package('cron') do
  it { should be_installed }
end

describe package('inetutils-ping') do
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

describe package('rsyslog') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end

describe package('vim-tiny') do
  it { should be_installed }
end

