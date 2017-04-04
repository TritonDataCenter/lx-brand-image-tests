require 'spec_helper'

describe file('/etc/apt/sources.list') do
  it { should be_file }
  it { should contain "deb http://nginx.org/packages/ubuntu/ trusty nginx" }
  it { should contain "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" }
end
