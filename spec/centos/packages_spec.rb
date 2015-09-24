require 'spec_helper'

describe package('ca-certificates') do
  it { should be_installed }
end

describe package('cronie') do
  it { should be_installed }
end

describe package('iputils') do
  it { should be_installed }
end

# The @core installation does not include 'man'...
describe package('man') do
  it { should be_installed }
end

# For CentOS 7. Required to install ifconfig
describe package('net-tools') do
  it { should be_installed }
end

describe package('openssh-clients') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end

describe package('which') do
  it { should be_installed }
end
