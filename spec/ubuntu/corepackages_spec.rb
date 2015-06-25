require 'spec_helper'

describe package('cron') do
  it { should be_installed }
end

describe package('curl') do
  it { should be_installed }
end

describe package('iputils-ping') do
  it { should be_installed }
end

describe package('less') do
  it { should be_installed }
end

describe package('openssh-server') do
  it { should be_installed }
end

describe package('net-tools') do
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

describe package('wget') do
  it { should be_installed }
end

describe package('whiptail') do
  it { should be_installed }
end
