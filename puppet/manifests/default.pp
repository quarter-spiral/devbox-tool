# Make sure apt-get -y update runs before anything else.
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { '/usr/bin/apt-get -y update':
    user => 'root'
  }
}
class { 'apt_get_update':
  stage => preinstall
}

class install_sqlite3 {
  package { 'sqlite3':
    ensure => installed;
  }

  package { 'libsqlite3-dev':
    ensure => installed;
  }
}
class { 'install_sqlite3': }

#class install_postgres {
  #class { 'postgresql': }

  #class { 'postgresql::server': }

  #pg_user { 'qs':
    #ensure  => present,
    #require => Class['postgresql::server']
  #}

  #pg_user { 'vagrant':
    #ensure    => present,
    #superuser => true,
    #require   => Class['postgresql::server']
  #}

  #package { 'libpq-dev':
    #ensure => installed
  #}
#}
#class { 'install_postgres': }

class install_core_packages {
  package { ['build-essential', 'git-core']:
    ensure => installed
  }
}
class { 'install_core_packages': }

class install_nokogiri_dependencies {
  if ! defined(Package['libxml2'])      { package { 'libxml2':      ensure => installed } }
  if ! defined(Package['libxml2-dev'])  { package { 'libxml2-dev':  ensure => installed } }
  if ! defined(Package['libxslt1-dev']) { package { 'libxslt1-dev': ensure => installed } }
}
class { 'install_nokogiri_dependencies': }

class install_java {
  if ! defined(Package['openjdk-7-jre-headless']) { package { 'openjdk-7-jre-headless': ensure => installed } }
}
class { 'install_java': }

class install_neo4j {
  package { lsof: ensure => present }
  class { neo4j: }
}
Package['openjdk-7-jre-headless'] -> Class['neo4j']
class { 'install_neo4j': }

class { mongodb:
  ulimit_nofile => 40000,
}

class install_rbx_dependencies {
  if ! defined(Package['libtool']) { package { 'libtool': ensure => installed } }
}
class { 'install_rbx_dependencies': }

include rvm
rvm::system_user { vagrant: ; }

if $rvm_installed == "true" {
  # Hax to fix permissions to install rbx
  exec { "fix rbx' rvm dependencies permissions":
    command   => "/usr/local/rvm/bin/rvm install rbx-head;sudo chown -R vagrant /usr/local/rvm/src/",
    unless    => "/usr/local/rvm/bin/rvm list|grep rbx"
  }

  rvm_system_ruby {
    'ruby-1.9.3-p194':
      ensure => 'present',
      default_use => false;
    'jruby-1.6.7.2':
      ensure      => 'present',
      default_use => false;
    'rbx-head':
      ensure      => 'present',
      default_use => false
  }

  rvm_gem {
    'bundler':
      name => 'bundler',
      ruby_version => 'ruby-1.9.3-p194',
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];
    'puppet':
      name => 'puppet',
      ruby_version => 'ruby-1.9.3-p194',
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];
    'rake':
      name => 'rake',
      ruby_version => 'ruby-1.9.3-p194',
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];

  }
}

class { 'memcached': }
