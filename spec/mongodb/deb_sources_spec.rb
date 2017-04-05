require 'spec_helper'

describe file('/etc/apt/sources.list.d/mongodb-org-3.4.list') do
  it { should be_file }
  it { should contain "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" }
end
