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
  $pkg_provider         = $::splunkforwarder::params::pkg_provider,
  $pkg_src              = $::splunkforwarder::params::pkg_src,
  $splunk_home          = $::splunkforwarder::params::splunk_home,
  $service              = $::splunkforwarder::params::service,
  $splunk_servertype    = 'enterprise',
  $splunk_servergroup   = 'indexers',
  $splunk_serverlist    = [],
  $splunk_inputs        = {},
  $splunk_uid           = 60000,
  $splunk_gid           = 60000,
  $username             = 'admin',
  $password             = 'changeme',
  $splunk_cloudapp      = undef,
  $puppet_fileserver    = undef,
) inherits splunkforwarder::params {

  if $splunk_servertype in ['cloud', 'enterprise'] {
    include splunkforwarder::install
    include splunkforwarder::service
    include splunkforwarder::config
  }
  else {
    fail("Forwarder type: ${type} is not a supported Splunkforwarder type.")
  }
}
