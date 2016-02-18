require 'spec_helper'

describe command('npm -v') do
  its(:exit_status) { should eq 0 }
end

# Install various popular packages.
# See https://www.npmjs.com/browse/star for source of some of these

describe command('npm install -g json') do
  its(:exit_status) { should eq 0 }
end

describe command('json --version') do
  its(:exit_status) { should eq 0 }
end

describe command('npm rm -g json') do
  its(:exit_status) { should eq 0 }
end

describe command('which json') do
  its(:exit_status) { should eq 1 }
end

describe command('npm install -g gulp-cli') do
  its(:exit_status) { should eq 0 }
end

describe command('gulp -h') do
  its(:exit_status) { should eq 0 }
end

describe command('npm rm -g gulp-cli') do
  its(:exit_status) { should eq 0 }
end

describe command('which gulp') do
  its(:exit_status) { should eq 1 }
end

describe command('npm install async') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install bunyan') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install express') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install hapi') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install mocha') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install moment') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install mongoose') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install request') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install restify') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install socket.io') do
  its(:exit_status) { should eq 0 }
end

describe command('npm install underscore') do
  its(:exit_status) { should eq 0 }
end