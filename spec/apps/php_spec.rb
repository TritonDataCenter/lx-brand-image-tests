require 'spec_helper'

# Ubuntu PHP install

describe command('grep -q Ubuntu /etc/product && apt-get install -y php5') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu PHP phpinfo() test

describe command('grep -q Ubuntu /etc/product && echo "<?php phpinfo(); ?>" >> test.php && php test.php') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu PHP php info test command line

describe command('grep -q Ubuntu /etc/product && php -i') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu PHP php list modules test command line

describe command('grep -q Ubuntu /etc/product && php -m') do
  its(:exit_status) { should eq 0 }
end
