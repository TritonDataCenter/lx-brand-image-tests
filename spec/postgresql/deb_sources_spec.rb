require 'spec_helper'

describe file('/etc/apt/sources.list') do
  it { should be_file }
  it { should contain "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.6" }
end
