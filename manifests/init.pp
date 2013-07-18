# = Class: splunkforwarder
#
# This class installs splunkforwarder and sets up a basic configuration
#
# == Parameters:
#
# [*splunk_servergroup*]
#   Name of splunk receiving group, defaults to indexers
#
# [*splunk_serverlist*]
#   Array of all receiving splunk servers
#
class splunkforwarder (
  $owner                = $::splunkforwarder::params::owner,
  $group                = $::splunkforwarder::params::group,
  $package              = $::splunkforwarder::params::package,
  $splunk_home          = $::splunkforwarder::params::splunk_home,
  $service              = $::splunkforwarder::params::service,
  $splunk_servergroup   = 'indexers',
  $splunk_serverlist    = [],

) inherits splunkforwarder::params {

  include splunkforwarder::packages
  include splunkforwarder::config
  include splunkforwarder::service

}
