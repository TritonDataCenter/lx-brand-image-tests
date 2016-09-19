require 'spec_helper'

describe package('ca-certificates') do
  it { should be_installed }
end

describe package('cronie') do
  it { should be_installed }
end

describe package('gettext') do
  it { should be_installed }
end

describe package('iputils') do
  it { should be_installed }
end

describe package('man-db') do
it { should be_installed }
end

describe package('net-tools') do
  it { should be_installed }
end

describe package('openssh-clients') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end

describe package('tar') do
  it { should be_installed }
end

describe package('which') do
  it { should be_installed }
end
