require 'spec_helper'

describe package('bash') do
  it { should be_installed }
end

describe package('openssh') do
  it { should be_installed }
end
