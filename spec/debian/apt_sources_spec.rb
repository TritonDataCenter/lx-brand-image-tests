require 'spec_helper'

describe file('/etc/apt/sources.list') do
  it { should be_file }
  it { should contain "deb http://httpredir.debian.org/debian wheezy main" }
  it { should contain "deb-src http://httpredir.debian.org/debian wheezy main" }
  it { should contain "deb http://httpredir.debian.org/debian wheezy-updates main" }
  it { should contain "deb-src http://httpredir.debian.org/debian wheezy-updates main" }
  it { should contain "deb http://security.debian.org/ wheezy/updates  main" }
  it { should contain "deb-src http://security.debian.org/ wheezy/updates  main" }
end
