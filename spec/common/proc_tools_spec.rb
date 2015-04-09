require 'spec_helper'

# Test symlinked proc tools 

describe command('pcred') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('pfiles') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('pflags') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

# Skip this test for Ubuntu. It has a native version of pldd
if !property[:name].include? "Ubuntu"
  describe command('pldd') do
    its(:exit_status) { should eq 2 }
    its(:stdout) { should contain('usage:') }
  end
end

# Show cpu usage once for a 2 second sampling interval
describe command('prstat -Z -s cpu 1 2') do
  its(:exit_status) { should eq 0 }
end

describe command('prun') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('psig') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('pstack') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('pstop') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('ptime') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end

describe command('pwait') do
  its(:exit_status) { should eq 2 }
  its(:stdout) { should contain('usage:') }
end
