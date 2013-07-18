# = Class: splunkforwarder::packages
#
# Installation of the splunk package
#
class splunkforwarder::packages (
  $package = $::splunkforwarder::package,
) inherits splunkforwarder {

  package { $package:
    ensure  => installed,
    require => User['splunk'],
  }

}

