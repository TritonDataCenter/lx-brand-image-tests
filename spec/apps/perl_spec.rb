require 'spec_helper'

# Ubuntu Perl install

describe command('grep -q Ubuntu /etc/product && apt-get install -y perl') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Perl version test

describe command('grep -q Ubuntu /etc/product && perl -v') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Perl print configuration summary

describe command('grep -q Ubuntu /etc/product && perl -V') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Perl various one liners

describe command('grep -q Ubuntu /etc/product && perl -E \'say "Hello World"\'') do
  its(:exit_status) { should eq 0 }
end

describe command('grep -q Ubuntu /etc/product && perl -e \'print "Hello";\'') do
  its(:exit_status) { should eq 0 }
end

describe command('grep -q Ubuntu /etc/product && echo test | perl -nle "print"') do
  its(:exit_status) { should eq 0 }
end

describe command('grep -q Ubuntu /etc/product && perl -le \'print "$0 and $ARGV[0] $ARGV[1] $ARGV[2]"\' first second third') do
  its(:exit_status) { should eq 0 }
end

describe command('grep -q Ubuntu /etc/product && perl -nle \'BEGIN { $n = shift } print "$. $n"\' foo /etc/passwd?') do
  its(:exit_status) { should eq 0 }
end
