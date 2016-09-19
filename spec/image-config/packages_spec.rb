require 'spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe package('less') do
  it { should be_installed }
end

# On CentOS and Fedora the package is called vim-enhanced
if file('/etc/redhat-release').exists?
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
