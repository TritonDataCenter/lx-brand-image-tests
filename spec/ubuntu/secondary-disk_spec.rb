require 'spec_helper'

# 
describe file('/mnt') do
  it { should be_directory }
  it { should be_mounted }
end
