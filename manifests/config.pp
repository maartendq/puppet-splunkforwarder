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
  $splunk_inputs           = $::splunkforwarder::splunk_inputs,
  $package                 = $::splunkforwarder::package,
  $owner                   = $::splunkforwarder::owner,
  $group                   = $::splunkforwarder::group,
  $username                = $::splunkforwarder::username,
  $password                = $::splunkforwarder::password,
  $service                 = $::splunkforwarder::service,
  $splunk_home             = $::splunkforwarder::splunk_home,
  $splunk_servertype       = $::splunkforwarder::splunk_servertype,
  $splunk_servergroup      = $::splunkforwarder::splunk_servergroup,
  $splunk_serverlist       = $::splunkforwarder::splunk_serverlist,
  $splunk_cloudapp         = $::splunkforwarder::splunk_cloudapp,
  $puppet_fileserver       = $::splunkforwarder::puppet_fileserver,
) inherits splunkforwarder {

  File {
    owner   => $owner,
    group   => $group,
    require => Package[$package],
  }

  if $splunk_servertype == 'cloud' {
    if $puppet_fileserver and $splunk_cloudapp {
      file { "${splunk_home}/${splunk_cloudapp}":
        ensure => present,
        mode   => '0600',
        source => "${puppet_fileserver}/${splunk_cloudapp}",
      }

      $cloudapp_folder = regsubst($splunk_cloudapp, '.tar.gz', '')
      notify{"The value is: ${cloudapp_folder}": }

      exec { 'install_splunkcloud_app':
        command => "${splunk_home}/bin/splunk install app ${splunk_home}/${splunk_cloudapp} -update 1 -auth ${username}:${password}",
        creates => "${splunk_home}/etc/apps/$cloudapp_folder",
        require => [
          File["${splunk_home}/${splunk_cloudapp}"],
          Service[$service],
        ],
        notify => Exec['restart_after_appinstall'],
      }

      exec { 'restart_after_appinstall':
        command => "/etc/init.d/splunk restart",
        refreshonly => true,
      }
    }
    else {
      fail("Please define puppet_fileserver and splunk_cloudapp when using Cloud servertype")
    }
  }

  else {
    file { "${splunk_home}/etc/system/local/outputs.conf":
      ensure  => present,
      mode    => '0600',
      content => template("${module_name}/splunk_local_outputs.erb"),
      notify  => Service[$service],
    }
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

  create_resources('splunkforwarder::inputs', $splunk_inputs)

}
