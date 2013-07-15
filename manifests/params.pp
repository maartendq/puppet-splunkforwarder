# = Class: splunkforwarder::params
#
# Initialize distro specific parameters/settings.
#
class splunkforwarder::params {

  case $::osfamily {
    'RedHat': {
      $owner       = 'splunk'
      $group       = 'splunk'
      $package     = 'splunkforwarder'
      $splunk_home = '/opt/splunkforwarder'
      $service     = 'splunk'
    }

    default: {
      $package     = 'splunkforwarder'
      $splunk_home = '/opt/splunkforwarder'
    }
  }
}
