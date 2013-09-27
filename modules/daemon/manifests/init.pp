# Class: daemon
#
# This module installs the daemon package
#
# Fetch rpms for additional architectures from 
# http://www.libslack.org/daemon/
#
class daemon {
  package { "daemon":
    ensure => installed,
    source => "puppet:///daemon/files/daemon-0.6.4-1.${::architecture}.rpm"
  }
}
