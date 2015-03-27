require 'spec_helper'

# Test for symlinks for binaries in /native/usr/bin/

describe file('/usr/bin/mdb') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/mdb' }
end

describe file('/usr/bin/pcred') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pcred' }
end

describe file('/usr/bin/pfiles') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pfiles' }
end

describe file('/usr/bin/pflags') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pflags' }
end

describe file('/usr/bin/pldd') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pldd' }
end

describe file('/usr/bin/prstat') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/prstat' }
end

describe file('/usr/bin/prun') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/prun' }
end

describe file('/usr/bin/psig') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/psig' }
end

describe file('/usr/bin/pstack') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pstack' }
end

describe file('/usr/bin/pstop') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pstop' }
end

describe file('/usr/bin/ptime') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/ptime' }
end

describe file('/usr/bin/pwait') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pwait' }
end

describe file('/usr/bin/pwdx') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/pwdx' }
end

describe file('/usr/bin/truss') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/truss' }
end

describe file('/usr/bin/kstat') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/kstat' }
end

describe file('/usr/bin/zonename') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/bin/zonename' }
end

# Test for symlinks for binaries in /native/usr/sbin/

describe file('/usr/sbin/cpustat') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/cpustat' }
end
  
describe file('/usr/sbin/dtrace') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/dtrace' }
end
  
describe file('/usr/sbin/mdata-get') do
  it { should be_symlink }
	it { should be_linked_to '/native/usr/sbin/mdata-get' }
end

describe file('/usr/sbin/mdata-list') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-list' }
end

describe file('/usr/sbin/mdata-put') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-put' }
end

describe file('/usr/sbin/mdata-delete') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/mdata-delete' }
end

describe file('/usr/sbin/plockstat') do
  it { should be_symlink }
  it { should be_linked_to '/native/usr/sbin/plockstat' }
end

