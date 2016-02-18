require 'spec_helper'

# Node 12.x
if property[:name] =~ /v0.12./
  describe command('node -v') do
    its(:stdout) { should contain('v0.12.10') }
  end
end

# Node 4.x
if property[:name] =~ /v4./
  describe command('node -v') do
    its(:stdout) { should contain('v4.3.1') }
  end
end
