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
  $package               = $::splunkforwarder::params::package,
) inherits splunkforwarder::params {

  class {'splunkforwarder::packages': }
  class {'splunkforwarder::config' : }

}
