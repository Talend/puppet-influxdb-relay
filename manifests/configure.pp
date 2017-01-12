#
# == Class: influxdb_relay::configure
#
# This class manage the configuration for influxdb-relay
#
class influxdb_relay::configure {
  concat { $::influxdb_relay::params::configuration_file:
    path  => $::influxdb_relay::params::configuration_file,
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  unless empty($::influxdb_relay::http_configurations) {
    create_resources(influxdb_relay::configure::http, $::influxdb_relay::http_configurations)
  }
  unless empty($::influxdb_relay::udp_configurations) {
    create_resources(influxdb_relay::configure::udp, $::influxdb_relay::udp_configurations)
  }
}
