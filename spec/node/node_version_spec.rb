require 'spec_helper'

# Node 12.x
if property[:name] =~ /nodejs-0.12/
  describe command('node -v') do
    its(:stdout) { should_not contain('v0.12.10') }
  end
end

# Node 4.x
if property[:name] =~ /nodejs-4/
  describe command('node -v') do
    its(:stdout) { should_not contain('v4.3.1') }
  end
end
