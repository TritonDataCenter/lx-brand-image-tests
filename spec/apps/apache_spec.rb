require 'spec_helper'

# Ubuntu Apache install with siege 

describe command('grep -q Ubuntu /etc/product && apt-get install -y apache2 siege') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Apache wget index.html

describe command('grep -q Ubuntu /etc/product && wget http://localhost/index.html') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Apache curl index.html

describe command('grep -q Ubuntu /etc/product && curl http://localhost/index.html') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Apache siege test for 10 seconds

describe command('grep -q Ubuntu /etc/product && siege -q -c5 -t10s http://localhost/index.html') do
  its(:exit_status) { should eq 0 }
end
