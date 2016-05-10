require 'spec_helper'

# Ubuntu Nginx install with siege 

describe command('grep -q Ubuntu /etc/product && apt-get install -y nginx siege') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Nginx wget index.html

describe command('grep -q Ubuntu /etc/product && wget http://localhost/index.html') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Nginx check index.html is correct

describe file('/root/index.html') do
   it { should be_file }
   it { should contain "Welcome to nginx!" }
end

# Ubuntu Nginx siege test for 10 seconds

describe command('grep -q Ubuntu /etc/product && siege -q -c5 -t10s http://localhost/index.html') do
  its(:exit_status) { should eq 0 }
end
