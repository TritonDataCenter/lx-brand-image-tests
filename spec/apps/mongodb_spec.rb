require 'spec_helper'

# Ubuntu and Debian tests
# MongoDB install and version test
if file('/etc/debian_version').exists?
  describe command('apt-get update -y && apt-get install -y mongodb && mongo --eval="db.version();"') do
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
  
  # MongoDB cluster setup create data dirs
  describe command('mkdir -p /var/lib/mongodb1 /var/lib/mongodb2 /var/lib/mongodb3') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup node1
  describe command('mongod --fork --port 27011 --dbpath /var/lib/mongodb1 --replSet rs1 --smallfiles --oplogSize 128 --logpath /var/log/mongodb/mongodb1.log') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup node2
  describe command('mongod --fork --port 27012 --dbpath /var/lib/mongodb2 --replSet rs1 --smallfiles --oplogSize 128 --logpath /var/log/mongodb/mongodb2.log') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup node3
  describe command('mongod --fork --port 27013 --dbpath /var/lib/mongodb3 --replSet rs1 --smallfiles --oplogSize 128 --logpath /var/log/mongodb/mongodb3.log') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup set configuration
  describe command('mongo --port 27011 --eval="rsconf = { _id: \"rs1\", members: [ { _id: 0, host: \"localhost:27011\" } ] }; rs.initiate( rsconf )"') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup add node2 to configuration
  describe command('sleep 25 && mongo --port 27011 --eval="rs.add(\"localhost:27012\")"') do
    its(:exit_status) { should eq 0 }
  end
  
  # MongoDB cluster setup add node3 to configuration
  describe command('sleep 25 && mongo --port 27011 --eval="rs.add(\"localhost:27013\")"') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB cluster setup import delicious
  describe command('mongoimport --port 27011 --db db1 --collection docs < delicious-rss-1250k') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB cluster setup dump node1
  describe command('mongodump --port 27011 -o dumpfile1') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB cluster setup dump node2
  describe command('mongodump --port 27012 -o dumpfile1') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB cluster setup dump node3
  describe command('mongodump --port 27013 -o dumpfile1') do
    its(:exit_status) { should eq 0 }
  end

  # MongoDB server clean up files
  describe command('rm -rf delicious* dumpfile1*') do
    its(:exit_status) { should eq 0 }
  end
end
