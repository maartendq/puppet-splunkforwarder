# = Class: splunkforwarder::config
#
# Basic configuration of splunkforwarder
#
# == TODO:
#
# * Update documentation
# * Make inputs.conf more generic
# * Create augeas crap to add/remove monitors or servers in inputs/outputs
#
class splunkforwarder::config (
  $inputs_local_blacklist  = undef,
  $inputs_local_sourcetype = undef,
  $splunk_inputs           = $::splunkforwarder::splunk_inputs,
  $owner                   = $::splunkforwarder::owner,
  $group                   = $::splunkforwarder::group,
  $service                 = $::splunkforwarder::service,
  $splunk_home             = $::splunkforwarder::splunk_home,
  $splunk_servergroup      = $::splunkforwarder::splunk_servergroup,
  $splunk_serverlist       = $::splunkforwarder::splunk_serverlist,
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
    notify  => Service[$service],
  }

  file { "${splunk_home}/etc/apps/search/local/":
    ensure => directory,
    mode   => '0755',
  }

  file { "${splunk_home}/etc/apps/search/local/inputs.conf":
    ensure  => present,
    mode    => '0600',
    content => template("${module_name}/splunk_local_inputs.erb"),
  }

  create_resources('splunkforwarder::inputs', $splunk_inputs)

}
