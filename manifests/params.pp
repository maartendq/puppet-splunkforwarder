# = Class: splunkforwarder::params
#
# Initialize distro specific parameters/settings.
#
class splunkforwarder::params {

  case $::osfamily {
    'RedHat': {
      $package = 'splunkforwarder'
    }

    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }
}
