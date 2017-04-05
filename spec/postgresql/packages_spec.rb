require 'spec_helper'

describe package('postgresql-9.6') do
  it { should be_installed }
end
