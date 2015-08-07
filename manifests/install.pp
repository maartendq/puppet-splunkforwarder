# = Class: splunkforwarder::install
#
# Installation of the splunk package
#
class splunkforwarder::install (
  $package = $::splunkforwarder::package,
  $owner   = $::splunkforwarder::owner,
  $group   = $::splunkforwarder::group,
) inherits splunkforwarder {

  File {
    owner   => $owner,
    group   => $group,
  }

  group {'splunk':
    ensure  => present,
    gid     => 60000,
  }

  user {'splunk':
    ensure     => present,
    uid        => 60000,
    gid        => 60000,
    home       => '/opt/splunkforwarder',
    require    => Group['splunk'],
  }

  package { $package:
    ensure  => installed,
    require => User['splunk'],
  }

  exec { 'splunk_initial_setup':
    command => "${splunk_home}/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt",
    creates => '/etc/init.d/splunk',
    require => Package[$package],
  }

}
