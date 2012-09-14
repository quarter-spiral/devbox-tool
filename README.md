# A Virtual Machine for Quarter Spiral Development

## Introduction

This project automates the setup of a development environment for all Quarter Spiral development.

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/quarter-spiral/devbox-tool.git
    host $ cd devbox-tool
    host $ vagrant up
    host $ vagrant reload
    # Wait a looong time
    host $ cd /vagrant/qs_code/setup
    # Approve use of rvm
    host $ bundle install
    host $ rake
    # Wait while all our repos are checked out


That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@rails-dev-box:~$

## Starting Metaserver

``
host $ vagrant ssh
# Run these two lines only the first time you start the metaserver
vagrant@qs-dev-box:~$ cd /vagrant/qs_code/projects/auth-backend/
vagrant@qs-dev-box:~$ bundle exec rake:migrate

# This is the actual start of the metaserver
vagrant@qs-dev-box:~$ cd /vagrant/qs_code/projects/metaserver-tool
vagrant@qs-dev-box:/vagrant/qs_code/projects/metaserver-tool$ bundle exec rackup -p 8183
``

Not head over to http://localhost:8183/ to see the metaserver.

### Credentials

The metaserver automatically creates a user named ``Jack`` in the auth backend for you. His password is ``quarterspiral``. He also is an admin so that you can use him to add more users or OAuth applications later on.


## What's In The Box

* Git

* RVM
  * MRI 1.9.3
  * JRuby
  * Rubinius (RBX) Head

* SQLite3 and Postgres

* System dependencies for nokogiri, sqlite3 and pg

* Memcached

* Neo4J

* MongoDB

* Setup script for all QS repos

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

You can find all QS projects at ``/vagrant/qs_code/projects`` within the
virtual machine. This directory is also within **THIS** project as
``./qs_code/projects`` so you can just use your normal editor on your
machine to edit the code right there!

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.
