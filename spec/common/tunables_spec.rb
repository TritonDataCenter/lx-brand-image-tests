require 'spec_helper'

# Test supported lx tunables. Only some are actually configurable
# to zones, others are there simply to prevent syscall failure

# configuration of net/core/somaxconn not supported on alpine yet
if property[:name] =~ /Alpine/
  describe command('sysctl net.core.somaxconn') do
    its(:exit_status) { should equal 0 }
  end
else
  describe command('sysctl net.core.somaxconn=256') do
    its(:exit_status) { should equal 0 }
  end
  describe command('sysctl net.core.somaxconn') do
    its(:stdout) { should contain "256" }
  end
end

describe command('sysctl vm.swappiness') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl vm.min_free_kbytes') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl vm.overcommit_memory') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl vm.nr_hugepages') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl fs.inotify') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.cap_last_cap') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.core_pattern') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.hostname') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.msgmni') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.ngroups_max') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.osrelease') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.pid_max') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.sem') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.shmall') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.shmmax') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.shmmni') do
  its(:exit_status) { should equal 0 }
end

describe command('sysctl kernel.threads-max') do
  its(:exit_status) { should equal 0 }
end
