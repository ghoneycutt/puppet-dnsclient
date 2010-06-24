#
# DNS client module
#
# Generate resolv.conf
#
# $nameservers and $dnssearchpath are specified in the site manifest
#
class dnsclient {

    file { "/etc/resolv.conf": 
        content => template("dnsclient/resolv.conf.erb"),
    }
} # class dnsclient
