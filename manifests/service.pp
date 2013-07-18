# = Class: splunkforwarder::service
#
# Initial service start and make sure splunk is running
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
