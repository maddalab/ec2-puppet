#!/bin/sh

# update the distribution to the latest 
yum update --assumeyes

# enable the puppetlabs repo for el6
rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm

# install puppet
yum install --assumeyes puppet

# install the aws cli tools
easy_install awscli

# install git
yum install --assumeyes git

# clone the repo and replace the default installed puppet files with new files
cd /etc
git clone https://github.com/maddalab/ec2-puppet.git puppet-git
mv puppet/auth.conf puppet-git
rm -rf puppet
mv puppet-git puppet

# install boto - aws python skd
easy_install boto

# make node terminus executable
chmod +x /etc/puppet/node_terminus.py

# Perform a quick test to make sure node terminus is running
/etc/puppet/node_terminus.py `hostname`

# run puppet to apply the required configuration
/usr/bin/pemuppet apply /etc/puppet/environments/production/manifests/site.pp
