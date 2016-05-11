require 'spec_helper'

describe package('curl') do
  it { should be_installed }
end

describe package('less') do
  it { should be_installed }
end

# On CentOS the package is called vim-enhanced

# TODO: Check for /etc/redhat-release ?

describe "vim" do
  it "should be installed" do
    # CentOS uses a different pacakge name
    if file('/etc/redhat-release').exists?
      package('vim-enhanced').installed?
    else
      package('vim').installed?
    end
  end
end

describe package('wget') do
  it { should be_installed }
end
