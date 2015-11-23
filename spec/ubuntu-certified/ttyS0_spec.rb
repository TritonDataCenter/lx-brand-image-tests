require 'spec_helper'

describe file('/etc/init/ttyS0.conf') do
  it { should be_file }
end

