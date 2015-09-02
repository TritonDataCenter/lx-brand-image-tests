require 'spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe package('less') do
  it { should be_installed }
end

describe package('vim') do
  it { should be_installed }
end

describe package('wget') do
  it { should be_installed }
end
