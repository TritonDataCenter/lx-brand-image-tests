# lx-brand-image-tests

These are the [Serverspec](http://serverspec.org) tests used to validate lx-beand images.

## Installation and Setup

To run the tests you will need ruby (1.9.3+ or 2.0.0 should work) and rubygems installed.

Install serverspec with

```
gem install serverspec
```

Add the name and properties of what you want to test to properties.yml. Next, edit your `~/.ssh/config` file with the host information of the virtual machines you want to test. The name you chose for _Host_ in `~/.ssh/config` should match what you have in properties.yml. 

For example, here's a properties.yml file:

```
base-13.3.1:
  :roles:
    - base-common
  :name: base
  :base_version: 13.3.1
  :doc_url: http://wiki.joyent.com/jpc2/SmartMachine+Base
```

And an example `~/.ssh/config` file:

```
Host base-13.3.1 
  HostName XX.X.XXX.XXX
  User root
```

## Running the tests

To run the tests, run the following command (within this directory):

```
rake serverspec
```

or just

```
rake
```

More information on how to create serverspec tests can be found here:

http://serverspec.org/tutorial.html

There's a list of useful Resource Types here that you can use for testing:

http://serverspec.org/resource_types.html
