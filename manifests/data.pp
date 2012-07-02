# == Class: dnsclient::data
#
# Provides data for dnsclient class
#
# === Variables
#
# See RESOLV.CONF(5) for more information regarding /etc/resolv.conf settings
#
# [*dnsclient_nameservers*]
#   List of name servers. Defaults to using Google's public name servers.
#
# [*dnsclient_options*]
#   Array of options. Defaults to 'rotate' and 'timeout:1'
#
# [*dnsclient_search*]
#   Array of domains for search list. Defaults to none. This is mutually
#   exclusive with dnsclient_domain. If both are set, dnsclient_search will be
#   used and dnsclient_domain will be ignored.
#
# [*dnsclient_domain*]
#   Domain setting. See *dnsclient_search*. Defaults to none.
#
# [*dnsclient_sortlist*]
#   Array of sortlist addresses. Defaults to none.
#
# [*dnsclient_resolver_config_file*]
#   Path to resolv.conf. Defaults to '/etc/resolv.conf'
#
# [*dnsclient_resolver_config_file_ensure*]
#   ensure attribute for file resource. Defaults to 'file'.
#
# [*dnsclient_resolver_config_file_owner*]
#   resolv.conf's owner. Defaults to 'root'
#
# [*dnsclient_resolver_config_file_group*]
#   resolv.conf's group. Defaults to 'root'
#
# [*dnsclient_resolver_config_file_mode*]
#   resolv.conf's mode. Defaults to '0644'
#
class dnsclient::data {

  # Use Google's public name servers if no others are specified.
  $nameservers = hiera('dnsclient_nameservers',[ '8.8.8.8',
                                                  '8.8.4.4' ])
  # timeout is measures in seconds and most systems default to 5, which is too
  # long to wait on a query. rotate allows your queries to be done with round
  # robin so you spread the load more evenly across name servers.
  $options     = hiera('dnsclient_options',['rotate',
                                          'timeout:1'])
  # if search path has more zones that example.com, such as pdx.example.com,
  # look into adding 'ndots:#' to your options array.
  $search      = hiera('dnsclient_search',['UNSET'])

  # Note that domain and search are mutually exclusive.
  $domain      = hiera('dnsclient_domain','UNSET')

  $sortlist    = hiera('dnsclient_sortlist',['UNSET'])

  # resource settings
  $resolver_config_file        = hiera('dnsclient_resolver_config_file','/etc/resolv.conf')
  $resolver_config_file_ensure = hiera('dnsclient_resolver_config_file_ensure','file')
  $resolver_config_file_owner  = hiera('dnsclient_resolver_config_file_owner','root')
  $resolver_config_file_group  = hiera('dnsclient_resolver_config_file_group','root')
  $resolver_config_file_mode   = hiera('dnsclient_resolver_config_file_mode','0644')

  # Validating $resolver_config_file_ensure for valid values
  case $resolver_config_file_ensure {
    'absent', 'file', 'present': {
      # noop, these values are valid
    }
    default: {
      fail("Valid values for \$resolver_config_file_ensure are 'absent', 'file', or 'present'")
    }
  }
}
