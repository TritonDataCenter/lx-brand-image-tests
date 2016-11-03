require 'spec_helper'

# Ubuntu and Debian tests
if file('/etc/debian_version').exists?
  
  # PostgreSQL install and version test
  describe command('apt-get update -y && apt-get -q -y install postgresql postgresql-contrib && su - postgres -c "psql -c \"select version();\""') do
    its(:exit_status) { should eq 0 }
  end

  # PostgreSQL create and drop database test
  describe command('su - postgres -c "psql -c \"select datname from pg_database;\"" && su - postgres -c "psql -c \"create database test1;\"" && su - postgres -c "psql -c \"drop database test1;\""') do
    its(:exit_status) { should eq 0 }
  end

  # PostgreSQL pgbench test
  describe command('su - postgres -c "createdb pgbench" && su - postgres -c "pgbench -i -c 16 -s 200"') do
    its(:exit_status) { should eq 0 }
  end
  
  # PostgreSQL pg_dumpall test
  describe command('su - postgres -c "pg_dumpall > dump1.sql"') do
    its(:exit_status) { should eq 0 }
  end
  
  # PostgreSQL pg_isready test
  describe command('su - postgres -c "pg_isready"') do
    its(:exit_status) { should eq 0 }
  end
  
  # PostgreSQL pg_lsclusters test
  describe command('su - postgres -c "pg_lsclusters"') do
    its(:exit_status) { should eq 0 }
  end
end
