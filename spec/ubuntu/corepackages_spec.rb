require 'spec_helper'

describe package('openssh-server') do
  it { should be_installed }
end

describe package('locales') do
  it { should be_installed }
end
