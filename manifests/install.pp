#
# == Class: influxdb_relay::install
#
# This class manage the installation of influxdb-relay
#
class influxdb_relay::install {
  if $::influxdb_relay::manage_repo {
    case $::osfamily {
      'Debian': {
        class { 'influxdb_relay::repositories::apt': }
      }
      'RedHat': {
        class { 'influxdb_relay::repositories::yum': }
      }
      default: {
        fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, the repos supported are for osfamily RedHat and Debian")
      }
    }
  }
  ensure_packages( 'influxdb-relay' => { ensure => $::influxdb_relay::version } )
}
