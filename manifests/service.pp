# = Class: splunkforwarder::service
#
# Description of splunkforwarder::service
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
class splunkforwarder::service (
  $splunk_home = $::splunkforwarder::splunk_home,
  $service     = $::splunkforwarder::service,
) inherits splunkforwarder {

  exec { 'splunk_initial_setup':
    command => "${splunk_home}/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt",
    creates => '/etc/init.d/splunk',
    require => Package['splunkforwarder'],
  }

  service { $service:
    ensure    => running,
    name      => $service,
    enable    => true,
    hasstatus => true,
    require   => Exec['splunk_initial_setup'],
  }

}
