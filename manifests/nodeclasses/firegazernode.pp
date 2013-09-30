class firegazernode {
  notify {"Kicking off provisioning of firegazer node":}

  include java
  include ruby
  include daemon

  # install logrotate package
  package { "logrotate.x86_64":
    ensure => latest;
  }

  # defaults on logrotate for redhat
  include logrotate::base 

  # set up log rotate for firegazer
  logrotate::rule { 'firegazer':
    path         => '/var/log/parmesan-http-health/*',
    compress     => true,
    size         => '6G',
    rotate       => 5,
    rotate_every => 'hour'
  } 

  # install capistrano for firegazer deployments
  package { 'capistrano':
    ensure   => present,
    provider => 'gem',
    require  => Package['rubygems'],
  }

  # create a cron job for puppet git pulls
  cron { puppet:
    command => "cd /etc/puppet && git reset --hard && git pull",
    user    => root,
    minute  => '*/10'
  }

  # create a cron job for puppet runs
  cron { puppet-run:
    command => "/usr/bin/puppet apply /etc/puppet/environments/production/manifests/site.pp -l /var/log/puppet/puppet.log --debug",
    user    => root,
    minute  => '*/10'
  }
}
