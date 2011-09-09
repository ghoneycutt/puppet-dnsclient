# Class: dnsclient
#
# This module manages /etc/resolv.conf and is meant to be included in the
# common class that applies to all systems
#
# Author: Garrett Honeycutt <code@garretthoneycutt.com>
#
# Requires:
#   class common::data
#   see http://www.puppetlabs.com/blog/design-pattern-for-dealing-with-data/
#
# Sample Usage:
#   include dnsclient
#
class dnsclient {

  include common::data
  include dnsclient::data

  if $common::data::nameservers {
    $nameservers = $common::data::nameservers
  } else {
    $nameservers = $dnsclient::data::nameservers
  } # fi

  if $common::data::dnssearchpath {
    $dnssearchpath = $common::data::dnssearchpath
  } else {
    $dnssearchpath = $dnsclient::data::dnssearchpath
  } # fi

  if $common::data::dnsclientoptions {
    $dnsclientoptions = $common::data::dnsclientoptions
  } else {
    $dnsclientoptions = $dnsclient::data::dnsclientoptions
  } # fi

  if $common::data::dnsclientsortlist {
    $dnsclientsortlist = $common::data::dnsclientsortlist
  } else {
    $dnsclientsortlist = $dnsclient::data::dnsclientsortlist
  } # fi

  file { '/etc/resolv.conf':
    content => template('dnsclient/resolv.conf.erb'),
  } # file
} # class dnsclient
