#
# == Class: influxdb_relay::service
#
# This class manage influxdb-relay service
#
class influxdb_relay::service {
  service { 'influxdb-relay':
    ensure => $::influxdb_relay::ensure_service
  }
}
