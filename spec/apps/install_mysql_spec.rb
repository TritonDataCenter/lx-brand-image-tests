require 'spec_helper'

# MySQL install and basic test

describe command('grep -q Ubuntu /etc/product && apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server && mysql -uroot -e "select * from mysql.user;"') do
  its(:exit_status) { should eq 0 }
end
