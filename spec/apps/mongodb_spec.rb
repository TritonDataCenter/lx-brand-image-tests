require 'spec_helper'

# Ubuntu MongoDB install and version test

describe command('grep -q Ubuntu /etc/product && apt-get install -y mongodb && mongo --eval="db.version();"') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu MongoDB basic collection test

describe command('grep -q Ubuntu /etc/product && mongo test3 --host localhost --eval="db.test3.save({country:\"England\",GroupName:\"D\"})" && mongo test3 --host localhost --eval="db.test3.find().forEach(printjson)"') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu MongoDB server information test

describe command('grep -q Ubuntu /etc/product && mongo --host localhost --eval="printjson(db.hostInfo())" && mongo --host localhost --eval="printjson(db.serverStatus())"') do
  its(:exit_status) { should eq 0 }
end

# Ubuntu MongoDB server mongostat test

describe command('grep -q Ubuntu /etc/product && mongostat -n 5') do
  its(:exit_status) { should eq 0 }
end
