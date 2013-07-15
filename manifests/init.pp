# = Class: splunkforwarder
#
# This class installs splunkforwarder
#
# == Parameters:
#
# [splunk_servers] : Comma seperated list of all receiving splunk servers
#
# == Actions:
#  - Install splunkforwarder
#
# == Requires:
#
# == Sample Usage:
#
class splunkforwarder (
  $owner                = $::splunkforwarder::params::owner,
  $group                = $::splunkforwarder::params::group,
  $package              = $::splunkforwarder::params::package,
  $splunk_home          = $::splunkforwarder::params::splunk_home,
  $service              = $::splunkforwarder::params::service,
  $splunk_servergroup   = 'indexers',
  $splunk_serverlist    = 'splunk.splunk.com:9997',
  $splunk_inputs        = [
    '/var/log/bla/',
    '/var/log/bla2',
  ],

) inherits splunkforwarder::params {

  include splunkforwarder::packages
  include splunkforwarder::config
  include splunkforwarder::service

}
