require 'spec_helper'

describe file('/etc/apt/sources.list.d/percona-release.list') do
  it { should be_file }
  it { should contain "deb http://repo.percona.com/apt trusty main" }
  it { should contain "deb-src http://repo.percona.com/apt trusty main" }
end
