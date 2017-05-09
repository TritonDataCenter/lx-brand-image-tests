require 'spec_helper'

# Ubuntu and Debian tests
# Only execute tests if MySQL is not installed
if ! file('/var/lib/mysql').exists?
  if file('/etc/debian_version').exists?
    describe command('apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server') do
      its(:exit_status) { should eq 0 }
    end

    # MySQL create and drop database test
    describe command('mysql -uroot -e "create database test1;" && mysql -uroot -e "drop database test1;"') do
      its(:exit_status) { should eq 0 }
    end

    # Sysbench install and oltp simple test (read only)
    describe command('apt-get install -y sysbench && mysql -uroot -e "create database test;" && sysbench --db-driver=mysql --oltp-test-mode=simple --num-threads=12 --test=oltp --mysql-host=127.0.0.1 --mysql-user=root --mysql-db=test --oltp-table-size=500000 prepare && sysbench --oltp-test-mode=simple --db-driver=mysql --num-threads=12 --test=oltp --mysql-host=127.0.0.1 --mysql-user=root --mysql-db=test --oltp-table-size=500000 --max-requests=500000 run') do
      its(:exit_status) { should eq 0 }
    end

    # Sysbench install and oltp complex test (read and write)
    describe command('sysbench --oltp-test-mode=complex --db-driver=mysql --num-threads=12 --test=oltp --mysql-host=127.0.0.1 --mysql-user=root --mysql-db=test --oltp-table-size=500000 --max-requests=500000 run') do
      its(:exit_status) { should eq 0 }
    end

    # mysqldump of test database
    describe command('mysqldump -uroot test > /root/test.sql') do
      its(:exit_status) { should eq 0 }
    end

    # mysqlimport of test database
    describe command('mysql -uroot -e "create database test2;" && mysql -uroot test2 < /root/test.sql') do
      its(:exit_status) { should eq 0 }
    end

    # MySQL replication setup
    # Setup master and slave configuration files
    describe command('service mysql stop') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "/skip-external-locking/a \server-id = 1\nlog-bin = mysqld-bin" /etc/mysql/my.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('cp /etc/mysql/my.cnf /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/mysqld-bin/mysqldslave-bin/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/3306/3307/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/mysqld\.sock/mysqldslave\.sock/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/mysqld\.pid/mysqldslave\.pid/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/lib\/mysql/lib\/mysqlslave/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/server-id = 1/server-id = 2/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sed -i "s/error\.log/errorslave\.log/g" /etc/mysql/my.slave.cnf') do
      its(:exit_status) { should eq 0 }
    end

    # Setup slave datadir
    describe command('mkdir /var/lib/mysqlslave && mysql_install_db --datadir=/var/lib/mysqlslave --defaults-file=/etc/mysql/my.slave.cnf --skip-name-resolve && chown -R mysql:mysql /var/lib/mysqlslave') do
      its(:exit_status) { should eq 0 }
    end

    # Start master and slave with new configurations
    describe command('service mysql start') do
      its(:exit_status) { should eq 0 }
    end
    
    describe command('printf "/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.slave.cnf > /dev/null 2>&1 &" > /etc/init.d/mysqlslave') do
      its(:exit_status) { should eq 0 }
    end

    describe command('chmod +x /etc/init.d/mysqlslave') do
      its(:exit_status) { should eq 0 }
    end

    describe command('/etc/init.d/mysqlslave') do
      its(:exit_status) { should eq 0 }
    end
    
    # Dump master and import into slave
    describe command('sleep 5 && mysqldump -uroot --master-data=2 -A --ignore-table=mysql.user --ignore-table=mysql.host --ignore-table=mysql.tables_priv --ignore-table=mysql.servers --ignore-table=mysql.db > masterdump.sql') do
      its(:exit_status) { should eq 0 }
    end

    describe command('sleep 10 && mysql --socket=/var/run/mysqld/mysqldslave.sock < /root/masterdump.sql') do
      its(:exit_status) { should eq 0 }
    end

    # Configure replication
    describe command('mysql -sN -e "grant replication slave, replication client on *.* to \'slave\'@\'%\' identified by \'pass123\'" 2> /dev/null') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql -sN -e "flush privileges" 2> /dev/null') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -sN -e "stop slave"') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -sN -e "reset master"') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -sN -e "reset slave"') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -sN -e "CHANGE MASTER TO master_user=\'slave\', master_password=\'pass123\', master_host=\'127.0.0.1\';"') do
      its(:exit_status) { should eq 0 }
    end

    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -sN -e "start slave"') do
      its(:exit_status) { should eq 0 }
    end
    
    # Check that replication is good
    describe command('mysql --socket=/var/run/mysqld/mysqldslave.sock -s -e "show slave status \G"') do
      its(:stdout) { should match /Slave_IO_Running: Yes/ }
      its(:stdout) { should match /Slave_SQL_Running: Yes/ }
    end
    
    # mysqlimport to test slave
    describe command('mysql -uroot -e "create database testslave;"') do
      its(:exit_status) { should eq 0 }
    end
    
    describe command('mysql -uroot testslave < /root/test.sql') do
      its(:exit_status) { should eq 0 }
    end
  end
end
