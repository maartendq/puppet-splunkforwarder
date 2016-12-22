# = Class: splunkforwarder::service
#
# Initial service start and make sure splunk is running
#
class splunkforwarder::service (
  $service     = $::splunkforwarder::service,
) inherits splunkforwarder {

  require splunkforwarder::install

  service { $service:
    ensure    => running,
    name      => $service,
    enable    => true,
    hasstatus => true,
  }

}
