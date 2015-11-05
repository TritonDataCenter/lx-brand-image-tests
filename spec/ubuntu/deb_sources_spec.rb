require 'spec_helper'


if property[:name].include? "Ubuntu 14.04"
  describe file('/etc/apt/sources.list') do
  	it { should be_file }
  	it { should contain "deb http://archive.ubuntu.com/ubuntu trusty main" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu trusty main" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu trusty-updates main" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu trusty-updates main" }
    it { should contain "deb http://security.ubuntu.com/ubuntu trusty-security main" }
    it { should contain "deb-src http://security.ubuntu.com/ubuntu trusty-security main" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu trusty universe" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu trusty universe" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu trusty-updates universe" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu trusty-updates universe" }
    it { should contain "deb http://security.ubuntu.com/ubuntu trusty-security universe" }
    it { should contain "deb-src http://security.ubuntu.com/ubuntu trusty-security universe" }
  end
end

if property[:name].include? "Ubuntu 15.04"
  describe file('/etc/apt/sources.list') do
  	it { should be_file }
  	it { should contain "deb http://archive.ubuntu.com/ubuntu vivid main" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu vivid main" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu vivid-updates main" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu vivid-updates main" }
    it { should contain "deb http://security.ubuntu.com/ubuntu vivid-security main" }
    it { should contain "deb-src http://security.ubuntu.com/ubuntu vivid-security main" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu vivid universe" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu vivid universe" }
    it { should contain "deb http://archive.ubuntu.com/ubuntu vivid-updates universe" }
    it { should contain "deb-src http://archive.ubuntu.com/ubuntu vivid-updates universe" }
    it { should contain "deb http://security.ubuntu.com/ubuntu vivid-security universe" }
    it { should contain "deb-src http://security.ubuntu.com/ubuntu vivid-security universe" }
  end
end



