require 'spec_helper'

describe package('apt-transport-https') do
  it { should be_installed }
end

describe package('ca-certificates') do
  it { should be_installed }
end

describe package('cron') do
  it { should be_installed }
end

describe package('dtracetools-lx') do
  it { should be_installed }
end

describe package('gettext-base') do
  it { should be_installed }
end

if property[:name].include? "Debian 8"
  describe package('iproute2') do
    it { should be_installed }
  end
end

if property[:name].include? "Debian 7"
  describe package('iproute') do
    it { should be_installed }
  end
end

describe package('net-tools') do
  it { should be_installed }
end

describe package('openssh-server') do
  it { should be_installed }
end


if property[:name].include? "Debian 7"
  describe package('python-software-properties') do
    it { should be_installed }
  end
end

if property[:name].include? "Debian 8"
  describe package('python-software-properties') do
    it { should be_installed }
  end
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
