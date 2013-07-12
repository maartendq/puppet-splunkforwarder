# = Class: splunkforwarder::packages
#
# Description of splunkforwarder::packages
#
# == Parameters:
#
# $param::   description of parameter. default value if any.
#
# == Actions:
#
# Describe what this class does. What gets configured and how.
#
# == Requires:
#
# Requirements. This could be packages that should be made available.
#
# == Sample Usage:
#
# == Todo:
#
# * Update documentation
#
class splunkforwarder::packages (
  $package = $::splunkforwarder::package,
) inherits splunkforwarder {

  package { $package:
    ensure  => installed,
    require => User['splunk'],
  }

}

