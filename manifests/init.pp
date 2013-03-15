# ## Class: dnsclient ##
#
# This module manages /etc/resolv.conf and is meant to be included in the
# common class that applies to all systems
#
# ### Parameters ###
#
# See RESOLV.CONF(5) for more information regarding /etc/resolv.conf settings
#
# nameservers
# -----------
# Array of name servers.
#
# - *Default*: Google's public name servers
#
# options
# -------
# Array of options.
#
# - *Default*: 'rotate' and 'timeout:1'
#
# search
# ------
# Array of domains for search list. This is mutually exclusive with **domain**. If both are set, search will be used and domain will be ignored.
#
# - *Default*: none
#
# domain
# ------
# Domain setting. See **search**.
#
# - *Default*: none
#
# sortlist
# --------
# Array of sortlist addresses.
#
# - *Default*: none
#
# resolver_config_file
# --------------------
# Path to resolv.conf.
#
# - *Default*: '/etc/resolv.conf'
#
# resolver_config_file_ensure
# ---------------------------
# ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# - *Default*: file
#
# resolver_config_file_owner
# --------------------------
# resolv.conf's owner.
#
# - *Default*: 'root'
#
#
# resolver_config_file_group
# --------------------------
# resolv.conf's group.
#
# - *Default*: 'root'
#
#
# resolver_config_file_mode
# -------------------------
# resolv.conf's mode.
#
# - *Default*: '0644'
#
class dnsclient                 (
  $nameservers                 = [ '8.8.8.8',
                                  '8.8.4.4' ],
  $options                     = [ 'rotate',
                                  'timeout:1'],
  $search                      = ['UNSET'],
  $domain                      = 'UNSET',
  $sortlist                    = ['UNSET'],
  $resolver_config_file        = '/etc/resolv.conf',
  $resolver_config_file_ensure = 'file',
  $resolver_config_file_owner  = 'root',
  $resolver_config_file_group  = 'root',
  $resolver_config_file_mode   = '0644',
) {

  # Validates domain
  if is_domain_name($domain) != true {
    fail("Domain name, ${domain}, is invalid.")
  }

  # Validates $resolver_config_file_ensure
  case $resolver_config_file_ensure {
    'file', 'present', 'absent': {
      # noop, these values are valid
    }
    default: {
      fail("Valid values for \$resolver_config_file_ensure are \'absent\', \'file\', or \'present\'. Specified value is ${resolver_config_file_ensure}")
    }
  }

  file { 'dnsclient_resolver_config_file':
    ensure  => $resolver_config_file_ensure,
    content => template('dnsclient/resolv.conf.erb'),
    path    => $resolver_config_file,
    owner   => $resolver_config_file_owner,
    group   => $resolver_config_file_group,
    mode    => $resolver_config_file_mode,
  }
}
