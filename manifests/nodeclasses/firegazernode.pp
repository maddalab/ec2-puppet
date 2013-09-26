class firegazernode {
  notify {"Kicking off provisioning of firegazer node":}

  include java
  include ruby

  # install capistrano for firegazer deployments
  package { 'capistrano':
    ensure => present,
    provider => 'gem',
    require => Package['rubygems'],
  }
}
