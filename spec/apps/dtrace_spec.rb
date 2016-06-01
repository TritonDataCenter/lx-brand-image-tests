require 'spec_helper'

# DTrace one liner tests

describe command('/native/usr/sbin/dtrace -l') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -V') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -n \'lx-syscall:::entry { @num[execname] = count(); } profile:::tick-1sec { exit(0); }\'') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -n \'lx-syscall:::entry { @num[pid, execname, probefunc] = count(); } profile:::tick-1sec { exit(0); }\'') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -n \'profile:::profile-1000hz { @Count[execname, pid] = lquantize(curlwpsinfo->pr_pri, 0, 170, 5); } profile:::tick-1sec { exit(0); }\'') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -n \'proc:::exec-success { trace(curpsinfo->pr_psargs); } profile:::tick-1sec { exit(0); }\'') do
  its(:exit_status) { should eq 0 }
end

describe command('/native/usr/sbin/dtrace -n \'lx-syscall::open:entry { printf("%s %s", execname, copyinstr(arg0)); } profile:::tick-1sec { exit(0); }\'') do
  its(:exit_status) { should eq 0 }
end
