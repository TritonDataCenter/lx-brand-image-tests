require 'spec_helper'

if property[:name].include? "Debian 8"
  describe file('/etc/apt/sources.list') do
    it { should be_file }
    it { should contain "deb http://httpredir.debian.org/debian jessie main" }
    it { should contain "deb-src http://httpredir.debian.org/debian jessie main" }
    it { should contain "deb http://httpredir.debian.org/debian jessie-updates main" }
    it { should contain "deb-src http://httpredir.debian.org/debian jessie-updates main" }
    it { should contain "deb http://security.debian.org/ jessie/updates  main" }
    it { should contain "deb-src http://security.debian.org/ jessie/updates  main" }
  end
end

if property[:name].include? "Debian 7"
  describe file('/etc/apt/sources.list') do
    it { should be_file }
    it { should contain "deb http://httpredir.debian.org/debian wheezy main" }
    it { should contain "deb-src http://httpredir.debian.org/debian wheezy main" }
    it { should contain "deb http://httpredir.debian.org/debian wheezy-updates main" }
    it { should contain "deb-src http://httpredir.debian.org/debian wheezy-updates main" }
    it { should contain "deb http://security.debian.org/ wheezy/updates  main" }
    it { should contain "deb-src http://security.debian.org/ wheezy/updates  main" }
  end
end