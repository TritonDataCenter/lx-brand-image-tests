require 'spec_helper'

describe package('cron') do
  it { should be_installed }
end

describe package('iputils') do
  it { should be_installed }
end

# The @core installation does not include 'man'...
describe package('man') do
  it { should be_installed }
end

describe package('openssh-clients') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end

describe package('vim-minimal') do
  it { should be_installed }
end

describe package('which') do
  it { should be_installed }
end
