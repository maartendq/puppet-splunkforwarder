# = Class: splunkforwarder::install
#
# Installation of the splunk package
#
class splunkforwarder::install (
  $package      = $::splunkforwarder::package,
  $pkg_provider = $::splunkforwarder::pkg_provider,
  $pkg_src      = $::splunkforwarder::pkg_src,
  $owner        = $::splunkforwarder::owner,
  $group        = $::splunkforwarder::group,
  $splunk_uid   = $::splunkforwarder::splunk_uid,
  $splunk_gid   = $::splunkforwarder::splunk_gid,
) inherits splunkforwarder {

  File {
    owner   => $owner,
    group   => $group,
  }

  group {'splunk':
    ensure  => present,
    gid     => $splunk_gid,
  }

  user {'splunk':
    ensure     => present,
    uid        => $splunk_uid,
    gid        => $splunk_gid,
    home       => '/opt/splunkforwarder',
    require    => Group['splunk'],
  }

  package { $package:
    ensure   => installed,
    provider => $pkg_provider,
    source   => $pkg_sruc,
    require  => User['splunk'],
  }

  exec { 'splunk_initial_setup':
    command => "${splunk_home}/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt",
    creates => '/etc/init.d/splunk',
    require => Package[$package],
  }

}
