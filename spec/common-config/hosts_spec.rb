require 'spec_helper'

describe file('/etc/hosts') do
  it { should exist }
  its(:content) { should match /127.0.0.1/ }
  its(:content) { should match /localhost/ }
end

