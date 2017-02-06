require 'spec_helper'

# Node 12.x
if property[:name] =~ /v0.12./
  describe command('node -v') do
    its(:stdout) { should contain('v0.12.17') }
  end
end

# Node 4.x
if property[:name] =~ /v4./
  describe command('node -v') do
    its(:stdout) { should contain('v4.7.3') }
  end
end

# Node 6.x
if property[:name] =~ /v6./
  describe command('node -v') do
    its(:stdout) { should contain('v6.9.5') }
  end
end
