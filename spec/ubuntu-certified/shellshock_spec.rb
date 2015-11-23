require 'spec_helper'

# Test to ensure bash isn't susceptible to Shellshock and friends
# Inspired by Docker's official library tests. See: https://github.com/docker-library/official-images/blob/master/test/tests/cve-2014--shellshock/shellshock_test.sh

# CVE-2014-6271
describe command("env x='() { :;}; echo vulnerable' bash -c \"echo this is a test\"") do
  its(:stdout) { should_not match /vulnerable/ }
end

# CVE-2014-6277
describe command("(shellshocker=\"() { x() { _;}; x() { _;} <<a; }\" bash -c date 2>/dev/null || echo vulnerable)") do
  its(:stdout) { should_not match /vulnerable/ }
end

# CVE-2014-6278
describe command("shellshocker='() { echo vulnerable; }' bash -c shellshocker 2>/dev/null") do
  its(:stdout) { should_not match /vulnerable/ }
end

# CVE-2014-7169
describe command("(cd /tmp; rm -f /tmp/echo; env X='() { (a)=>\' bash -c \"echo echo nonvuln\" 2>/dev/null; [[ \"$(cat echo 2> /dev/null)\" == \"nonvuln\" ]] && echo \"vulnerable\" 2> /dev/null)") do
  its(:stdout) { should_not match /vulnerable/ }
end

# CVE-2014-7186
describe command("(bash -c 'true <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF' 2>/dev/null || echo \"vulnerable\")") do
  its(:stdout) { should_not match /vulnerable/ }
end

## TODO: Fix this test
## This test passes when run on a VM but fails via Serverspec when bash is in fact patched.
## I suspect it has to do with how Serverspec runs the given command.
# CVE-2014-7187
#describe command("((for x in {1..200}; do echo \"for x$x in ; do :\"; done; for x in {1..200}; do echo done; done) | bash || echo 'vulnerable')") do
#  its(:stdout) { should_not match /vulnerable/ }
#end

# CVE-2014-////
describe command("env X=' () { }; echo vulnerable' bash -c 'date'") do
  its(:stdout) { should_not match /vulnerable/ }
end
