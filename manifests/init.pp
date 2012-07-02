# == Class: dnsclient
#
# This module manages /etc/resolv.conf and is meant to be included in the
# common class that applies to all systems
#
class dnsclient {

  include dnsclient::data

  $nameservers = $dnsclient::data::nameservers
  $search      = $dnsclient::data::search
  $domain      = $dnsclient::data::domain
  $options     = $dnsclient::data::options
  $sortlist    = $dnsclient::data::sortlist

  file { 'dnsclient_resolver_config_file':
    ensure  => $dnsclient::data::resolver_config_file_ensure,
    content => template('dnsclient/resolv.conf.erb'),
    path    => $dnsclient::data::resolver_config_file,
    owner   => $dnsclient::data::resolver_config_file_owner,
    group   => $dnsclient::data::resolver_config_file_group,
    mode    => $dnsclient::data::resolver_config_file_mode,
  }
}
