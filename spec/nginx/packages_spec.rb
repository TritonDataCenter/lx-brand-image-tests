require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end

describe package('php5-fpm') do
  it { should be_installed }
end
