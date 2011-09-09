# Class: dnsclient::data
#
# Provides default data for dnsclient class.
#
# Do NOT modify this data. To provide your own, set these variables in the
# common::data class. Data there will override these defaults.
#
class dnsclient::data {

  # Use Google's public name servers if no others are specified.
  $nameservers = [ '8.8.8.8', '8.8.4.4' ]

  # Variable data that does not have to be set.
  $dnssearchpath     = undef
  $dnsclientoptions  = undef
  $dnsclientsortlist = undef

} # class dnsclient::data
