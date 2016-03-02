require 'spec_helper'

# See https://github.com/joyent/ubuntu-lx-brand-image-builder/issues/13
describe command('ls -al /etc/cron.weekly/') do
	its(:stdout) { should_not match /fstrim/ }
end
