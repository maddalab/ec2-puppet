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

  # create a cron job for puppet git pulls
  cron { puppet:
    command => "cd /etc/puppet && git reset --hard && git pull",
    user    => root,
    minute  => '*/10'
  }

  # create a cron job for puppet runs
  cron { puppet-run:
    command => "/usr/bin/puppet apply /etc/puppet/environments/production/manifests/site.pp",
    user    => root,
    minute  => '*/10'
  }
}
