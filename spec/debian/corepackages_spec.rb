require 'spec_helper'

describe package('openssh-server') do
  it { should be_installed }
end

describe package('sudo') do
  it { should be_installed }
end

