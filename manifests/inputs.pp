# == Define: up_logrotate::rule
#
# Defines a logrotation schedule for a log file.
#
# === Parameters
#
#
# === Examples
#
# === TODO
# Add removal of sourcetype/blacklist/index in update template
# if parameter is left out
define splunkforwarder::inputs (
  $inputs_monitor,
  $inputs_ensure     = present,
  $inputs_index      = undef,
  $inputs_blacklist  = undef,
  $inputs_sourcetype = undef,
  $splunk_home       = $::splunkforwarder::splunk_home,
  $service           = $::splunkforwarder::service,
) {

  include splunkforwarder

  if $title == '' {
    fail('Can not create inputs with empty title/name')
  } else {
  $inputs_title = $title
  }

  Augeas {
    incl    => "${splunk_home}/etc/apps/search/local/inputs.conf",
    lens    => 'Splunk.lns',
    notify  => Service[$service],
    require => File["${splunk_home}/etc/apps/search/local/inputs.conf"],
  }

  case $inputs_ensure {
    'present', default: {
      augeas {"splunkforwarder::inputs::add-${inputs_title}":
        changes => template("${module_name}/splunk_inputs_add.augeas.erb"),
        onlyif  => "match target[. = '${inputs_monitor}'] size == 0",
      }
      augeas {"splunkforwarder::inputs::update-${inputs_title}":
        changes => template("${module_name}/splunk_inputs_update.augeas.erb"),
        onlyif  => "match target[. = '${inputs_monitor}'] size > 0",
      }
    }
    'absent': {
      augeas {"splunkforwarder::inputs::rm-${inputs_title}":
        changes => "rm target[. = '${inputs_monitor}']",
      }
    }

  }
}
