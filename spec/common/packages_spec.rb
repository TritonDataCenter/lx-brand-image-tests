require 'spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe package('less') do
  it { should be_installed }
end

# On CentOS the package is called vim-enhanced

if property[:name].include? "CentOS"
  describe package('vim-enhanced') do
    it { should be_installed }
  end
else
  describe package('vim') do
    it { should be_installed }
  end
end

describe package('wget') do
  it { should be_installed }
end
