require 'spec_helper'

# Ubuntu PostgreSQL install and version test

describe command('grep -q Ubuntu /etc/product && apt-get update -y && apt-get -q -y install postgresql postgresql-contrib && su - postgres -c "psql -c \"select version();\""') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu PostgreSQL create and drop database test

describe command('grep -q Ubuntu /etc/product && su - postgres -c "psql -c \"select datname from pg_database;\"" && su - postgres -c "psql -c \"create database test1;\"" && su - postgres -c "psql -c \"drop database test1;\""') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu PostgreSQL pgbench test

describe command('grep -q Ubuntu /etc/product && su - postgres -c "createdb pgbench" && su - postgres -c "pgbench -i -s 15"') do
  its(:exit_status) { should eq 0 }
end
