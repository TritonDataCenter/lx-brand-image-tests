require 'spec_helper'

# Ubuntu and Debian tests
# Ubuntu MongoDB install and version test

if file('/etc/debian_version').exists?
  describe command('apt-get install -y mongodb && mongo --eval="db.version();"') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB basic collection test

  describe command('mongo test3 --host localhost --eval="db.test3.save({country:\"England\",GroupName:\"D\"})" && mongo test3 --host localhost --eval="db.test3.find().forEach(printjson)"') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server information test

  describe command('mongo --host localhost --eval="printjson(db.hostInfo())" && mongo --host localhost --eval="printjson(db.serverStatus())"') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server mongostat test

  describe command('mongostat -n 5') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server grab delicious file

  describe command('wget http://randomwalker.info/data/delicious/delicious-rss-1250k.gz') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server gunzip delicious file

  describe command('gunzip -qf delicious-rss-1250k.gz') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server mongoimport delicious file

  describe command('mongoimport --db db1 --collection docs < delicious-rss-1250k') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB server mongodump delicious db1

  describe command('mongodump -o dumpfile1') do
    its(:exit_status) { should eq 0 }
  end
end
