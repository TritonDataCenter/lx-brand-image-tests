require 'spec_helper'

describe command('ls /etc/resolvconf/resolv.conf.d/') do
  its(:stdout) { should_not contain('original') }
end

