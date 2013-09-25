#!/usr/bin/python2.6

import boto.ec2
import logging
import re
import sys

# grab the hostnam
host = sys.argv[1]

def main():
    conn = boto.ec2.EC2Connection()
    reservations =  conn.get_all_instances()

    for reservation in reservations:
        for instance in reservation.instances:
            if re.search( str(host).lower(), str(instance.private_dns_name).lower() ):
                # print the yaml
                print "---"
                # print the enviroment
                print "enviroment:"
                print "  %s:" % instance.tags.get("environment")
                print "classes:"
                print "  %s:" % instance.tags.get("nodeclass")
                print "parameters:"
                print "  ec2:"
                for tag in instance.tags:
                    print "    %s: \"%s\"" % (tag, instance.tags.get(tag))

if __name__ == "__main__":
    main()