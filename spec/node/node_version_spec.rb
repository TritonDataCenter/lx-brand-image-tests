require 'spec_helper'

# Node 4.x
if property[:name] =~ /v4./
  describe command('node -v') do
    its(:stdout) { should contain('v4.8.1') }
  end
end

# Node 6.x
if property[:name] =~ /v6./
  describe command('node -v') do
    its(:stdout) { should contain('v6.10.1') }
  end
end
