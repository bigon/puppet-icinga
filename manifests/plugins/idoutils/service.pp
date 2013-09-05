# == Class: icinga::plugins::idoutils::service
#
# This class provides the idoutils plugin's service.
#
class icinga::plugins::idoutils::service {
  if ($::icinga::idoutils_enabled == true) {
    service { $icinga::idoutils_service:
      ensure    => running,
      enable    => true,
      hasstatus => true,
      subscribe => Class['icinga::plugins::idoutils::config'];
    }
    if ($::osfamily == 'Debian'){
      augeas { "IDO2DB":
        context => "/files/etc/default/icinga/",
        changes => [
          "set IDO2DB yes",
        ],
	before  => Service["$icinga::idoutils_service"],
      }
    }
  }
}
