# == Define: splunkforwarder::inputs
#
# Defines a monitor for splunkforwarder
#
# === Parameters
#
# [*inputs_monitor*]
#   Path of logfile that needs to be monitored (preceeded by monitor://)
#
# [*inputs_ensure*]
#   Parameter to be able to remove monitor
#
# [*inputs_index*]
#   Optional paramater - monitor index
#
# [*inputs_blacklist*]
#   Optional paramater - monitor blacklist
#
# [*inputs_sourcetype*]
#   Optional paramater - monitor sourcetype
#
# === Examples
#
# === TODO
# - Add removal of sourcetype/blacklist/index in update template
#   if parameter is left out - TEST IT
# - Provide example
#
define splunkforwarder::inputs (
  $inputs_monitor,
  $inputs_ensure     = present,
  $inputs_index      = undef,
  $inputs_blacklist  = undef,
  $inputs_sourcetype = undef,
  $splunk_home       = $::splunkforwarder::splunk_home,
  $service           = $::splunkforwarder::service,
) {

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
