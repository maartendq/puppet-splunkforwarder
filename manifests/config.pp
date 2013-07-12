# = Class: splunkforwarder::config
#
# Description of splunkforwarder::config
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
class splunkforwarder::config (
) inherits splunkforwarder {

  group {'splunk':
    ensure  => present,
    gid     => 5201,
  }

  user {'splunk':
    ensure     => present,
    uid        => 5201,
    gid        => 5201,
    home       => '/opt/splunkforwarder',
    require    => Group['splunk'],
  }

}
