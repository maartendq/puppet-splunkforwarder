# = Class: splunkforwarder::params
#
# Initialize distro specific parameters/settings.
#
# == Todo:
#
# * Add ubuntu params
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
      $owner       = 'splunk'
      $group       = 'splunk'
      $package     = 'splunkforwarder'
      $splunk_home = '/opt/splunkforwarder'
      $service     = 'splunk'
    }
  }
}
