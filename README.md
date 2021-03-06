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
    # Wait a looong time.
    host & vagrant ssh
    # Enter your Github credentials.
    # Then wait some more while all our repos
    # are checked out and bundled for you
    # by the devbox.

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

* Metaserver

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

## QS Shortcuts

There are some small tools included that make your life on the box a
bit easier.

### cdp

Run ``cdp`` to change to the projects directory.

### b

Run ``b`` to bundle install in a project.

### fixfiles

Sometimes file permissions are messed up when you edit files from your host system in this case just run ``fixfiles``.

### fixmongo

If Mongo dies you can restart it with ``fixmongo``.

### diemeta

If your meta server is in a b0rked state try to quit it an run ``diemeta`` afterwards to kill all the app servers.

### Hacking

If you want to add your own shortcuts just edit the
``/puppet/qs_code/setup/aliases`` file in the ``devbox-tool`` project
and run ``vagrant reload`` afterwards.
