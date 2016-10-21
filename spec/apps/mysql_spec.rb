require 'spec_helper'

# Ubuntu MySQL install and select test

describe command('grep -q Ubuntu /etc/product && apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server && mysql -uroot -e "select * from mysql.user;"') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu MySQL create and drop database test

describe command('grep -q Ubuntu /etc/product && mysql -uroot -e "create database test1;" && mysql -uroot -e "drop database test1;"') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Sysbench install and oltp simple test (read only)

describe command('grep -q Ubuntu /etc/product && apt-get install -y sysbench && mysql -uroot -e "create database test;" && sysbench --db-driver=mysql --oltp-test-mode=simple --num-threads=12 --test=oltp --mysql-host=localhost --mysql-user=root --mysql-db=test --oltp-table-size=5000000 prepare && sysbench --oltp-test-mode=simple --db-driver=mysql --num-threads=12 --test=oltp --mysql-host=localhost --mysql-user=root --mysql-db=test --oltp-table-size=5000000 --max-requests=500000 run') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu Sysbench install and oltp complex test (read and write)

describe command('grep -q Ubuntu /etc/product && sysbench --oltp-test-mode=complex --db-driver=mysql --num-threads=1 --test=oltp --mysql-host=localhost --mysql-user=root --mysql-db=test --oltp-table-size=5000000 --max-requests=500000 run') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu mysqldump of test database
describe command('grep -q Ubuntu /etc/product && mysqldump -uroot test > /root/test.sql') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu mysqlimport of test database
describe command('grep -q Ubuntu /etc/product && mysql -uroot -e "create database test2;" && mysql -uroot test2 < /root/test.sql') do
  its(:exit_status) { should eq 0 }
end
