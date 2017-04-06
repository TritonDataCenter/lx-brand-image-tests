require 'spec_helper'

describe package('percona-server-server-5.7') do
  it { should be_installed }
end

describe command('mysqld --version') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /5\.7\.17*/ }
end
