# Make sure we cang ping hosts and resolve them 
describe host('google.com') do
  it { should be_reachable }
  it { should be_resolvable }
end

describe host('joyent.com') do
  it { should be_reachable }
  it { should be_resolvable }
end