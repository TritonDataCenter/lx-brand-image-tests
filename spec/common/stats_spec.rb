require 'spec_helper'

# Test basic system commands for returning
# memory, cpu, storage and network stats

describe command('cat /proc/swaps | grep partition') do
  its(:exit_status) { should equal 0 }
end

describe command('free') do
  its(:exit_status) { should equal 0 }
  its(:stdout) { should contain 'Mem' }
  its(:stdout) { should contain 'Swap' }
end

if ! property[:name].include? "Alpine"
  describe command('vmstat') do
    its(:exit_status) { should equal 0 }
  end
end

describe command('df') do
  its(:exit_status) { should equal 0 }
end

describe command('du') do
  its(:exit_status) { should equal 0 }
end

describe command('netstat -a | grep ssh') do
  its(:exit_status) { should equal 0 }
  its(:stdout) { should contain 'ssh' }
end

describe command('ps aux | grep ssh') do
  its(:exit_status) { should equal 0 }
  its(:stdout) { should contain 'ssh' }
end

describe command('uptime') do
  its(:exit_status) { should equal 0 }
end

