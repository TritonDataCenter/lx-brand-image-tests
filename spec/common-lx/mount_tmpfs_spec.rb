require 'spec_helper'

# Test mount commands for tmpfs

describe command('mkdir /mnt/tmpfs') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -o noatime -t tmpfs tmpfs /mnt/tmpfs') do
  its(:exit_status) { should eq 0 }
end

describe file('/mnt/tmpfs') do
it do
    should be_mounted.with(
      :type    => 'tmpfs',
      :options => {
        :rw   => true 
      }
    )
  end
end

# removing a mounted directory should fail
describe command('rm -R /mnt/tmpfs') do
  its(:exit_status) { should eq 1 }
end

# umount and then remove should work
describe command('umount /mnt/tmpfs') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -v | grep "/mnt/tmpfs" | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /0/ }
end

describe command('rm -R /mnt/tmpfs') do
  its(:exit_status) { should eq 0 }
end

# size option - should accept size in bytes, k/m/g bytes 
describe command('mkdir /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -o size=4194304 -t tmpfs tmpfs /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('df /mnt/ramdisk | grep 4096 | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

describe command('umount /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -o size=8192k -t tmpfs tmpfs /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('df /mnt/ramdisk | grep 8192 | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

describe command('umount /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -o size=128m -t tmpfs tmpfs /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('df /mnt/ramdisk | grep 131072 | wc -l') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /1/ }
end

describe command('umount /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

# skip gb size on LX for now due to OS-5272
if ! property[:name].include? "LX"
  describe command('mount -o size=1g -t tmpfs tmpfs /mnt/ramdisk') do
    its(:exit_status) { should eq 0 }
  end

  describe command('df /mnt/ramdisk | grep 1048576 | wc -l') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /1/ }
  end

  describe command('umount /mnt/ramdisk') do
    its(:exit_status) { should eq 0 }
  end
end

# Remount /dev/shm with size specified in percentage
if ! file('/etc/centos-release').exists?
  describe file('/dev/shm') do
    it { should exist }
  end

  describe command('mount -o remount,size=10% /dev/shm') do
    its(:exit_status) { should eq 0 }
  end
end

# Test other supported options: noexec, mode, uid, gid, noauto

describe command('mount -t tmpfs tmpfs /mnt/ramdisk -o mode=755') do
  its(:exit_status) { should eq 0 }
end
 
describe command('echo "pwd" > /mnt/ramdisk/test1.sh && chmod +x /mnt/ramdisk/test1.sh && /mnt/ramdisk/test1.sh') do
  its(:exit_status) { should eq 0 }
end
 
describe command('umount /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

describe command('mount -t tmpfs tmpfs /mnt/ramdisk -o noexec') do
  its(:exit_status) { should eq 0 }
end
 
describe command('echo "pwd" > /mnt/ramdisk/test2.sh && chmod +x /mnt/ramdisk/test2.sh && /mnt/ramdisk/test2.sh') do
  its(:exit_status) { should eq 126 }
end
 
describe command('umount /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end

# Skip Alpine due to OS-5273 and packages not available in the image
if ! file('/etc/alpine-release').exists?
  describe command('groupadd foo') do
    its(:exit_status) { should eq 0 }
  end

  describe command('useradd bar -g foo && useradd foomember -g foo && useradd nonmember') do
    its(:exit_status) { should eq 0 }
  end

  describe command('mount -o noauto,mode=775,gid=foo,uid=bar -t tmpfs tmpfs /mnt/ramdisk') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/mnt/ramdisk') do
    it { should be_writable.by_user('bar') }
    it { should be_writable.by_user('foomember') }
    it { should_not be_writable.by_user('nonmember') }
  end

  describe command('umount /mnt/ramdisk') do
    its(:exit_status) { should eq 0 }
  end

  describe command('userdel bar && userdel foomember && userdel nonmember') do
    its(:exit_status) { should eq 0 }
  end

  describe command('groupdel foo') do
    its(:exit_status) { should eq 0 }
  end
end

describe command('rm -R /mnt/ramdisk') do
  its(:exit_status) { should eq 0 }
end
