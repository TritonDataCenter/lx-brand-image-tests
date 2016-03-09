require 'spec_helper'

describe command('groupadd foo') do
  its(:exit_status) { should equal 0 }
end

describe group('foo') do
  it { should exist }
end

describe group('wheel') do
  it { should exist }
end

describe command('usermod -a -G foo root') do
  its(:exit_status) { should eq 0 }
end

describe user('root') do
  it { should belong_to_group 'foo' }
end

describe command('groupdel foo') do
  its(:exit_status) { should eq 0 }
end

describe group('foo') do
  it { should_not exist }
end
