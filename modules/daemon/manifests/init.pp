# Class: daemon
#
# This module installs the daemon package
#
# Using the source built rpms from http://www.libslack.org/daemon/
#
class daemon {
  package { 'daemon':
    provider => 'rpm',
    ensure => installed,
    source => "http://libslack.org/daemon/download/daemon-0.6.4-1.${::architecture}.rpm"
  }
}
