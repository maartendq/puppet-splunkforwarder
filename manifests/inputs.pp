# == Define: up_logrotate::rule
#
# Defines a logrotation schedule for a log file.
#
# === Parameters
#
#
# === Examples
#
#
define splunkforwarder::inputs (
  $splunk_home       = $::splunkforwarder::splunk_home,
  $service           = $::splunkforwarder::service,
  $inputs_ensure     = present,
  $inputs_title,
  $inputs_monitor,
  $inputs_index,
  $inputs_blacklist  = undef,
  $inputs_sourcetype = undef,
) {

  include splunkforwarder

  Augeas {
    incl    => "${splunk_home}/etc/apps/search/local/inputs.conf",
    lens    => 'Splunk.lns',
    notify  => Service[$service],
    require => File["${splunk_home}/etc/apps/search/local/inputs.conf"],
  }


  case $inputs_ensure {
    'present', default: {
      augeas {"splunkforwarder::inputs::add-${inputs_title}":
        changes => [
          "set target[last()+1] ${inputs_monitor}",
          "set target[last()]/blacklist ${inputs_blacklist}",
          "set target[last()]/sourcetype ${inputs_sourcetype}",
          "set target[last()]/index ${inputs_index}",
        ],
        onlyif  => "match target[. = '${inputs_monitor}'] size == 0",
      }
      augeas {"splunkforwarder::inputs::update-${inputs_title}":
        changes => [
          "set target[. = '${inputs_monitor}']/blacklist ${inputs_blacklist}",
          "set target[. = '${inputs_monitor}']/sourcetype ${inputs_sourcetype}",
          "set target[. = '${inputs_monitor}']/index ${inputs_index}",
        ],
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
