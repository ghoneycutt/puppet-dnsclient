# Class: dnsclient
#
# This module manages /etc/resolv.conf
#
# Requires: $nameservers and $dnssearchpath which should be set in the site manifest
#
# Sample Usage: included in generic class that applies to all systems
#
class dnsclient {

    file { "/etc/resolv.conf": 
        content => template("dnsclient/resolv.conf.erb"),
    } # file
} # class dnsclient
