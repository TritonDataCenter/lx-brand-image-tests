require 'spec_helper'

# Test to ensure bash isn't susceptible to Shellshock (CVE-2014-6271)

# CVE-2014-6271
describe command("env x='() { :;}; echo vulnerable' bash -c \"echo this is a test\"") do
  its(:stderr) { should_not match /vulnerable/ }
end

# CVE-2014-7169
describe command("env X='() { (a)=>\' bash -c \"echo date\"") do
  its(:stderr) { should match /date/ }
end

describe file('date') do
  it { should_not exist }
end

