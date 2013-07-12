# = Class: splunkforwarder
#
# This class installs splunkforwarder
#
# == Parameters:
#
#
# == Actions:
#  - Install splunkforwarder
#
# == Requires:
#
# == Sample Usage:
#
class splunkforwarder (
  $package     = $::splunkforwarder::params::package,
  $splunk_home = $::splunkforwarder::params::splunk_home,
  $service     = $::splunkforwarder::params::service,
) inherits splunkforwarder::params {

  include splunkforwarder::packages
  include splunkforwarder::config
  include splunkforwarder::service

}
