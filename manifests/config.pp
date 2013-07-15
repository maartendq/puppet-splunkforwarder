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
# * Make inputs.conf more generic
# * Create augeas crap to add/remove monitors or servers in inputs/outputs
#
class splunkforwarder::config (
  $owner                = $::splunkforwarder::group,
  $group                = $::splunkforwarder::group,
  $splunk_home          = $::splunkforwarder::splunk_home,
  $splunk_servergroup   = $::splunkforwarder::splunk_servergroup,
  $splunk_serverlist    = $::splunkforwarder::splunk_serverlist,
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

  File {
    owner   => $owner,
    group   => $group,
    require => Package['splunkforwarder'],
  }

  file { "${splunk_home}/etc/system/local/outputs.conf":
    ensure  => present,
    mode    => '0600',
    content => template("${module_name}/splunk_local_outputs.erb"),
  }

  file { "${splunk_home}/etc/apps/search/local/":
    ensure => directory,
    mode   => '0755',
  }

  file { "${splunk_home}/etc/apps/search/local/inputs.conf":
    ensure  => present,
    mode    => '0600',
    replace => false,
    content => template("${module_name}/splunk_local_inputs.erb"),
  }

}
