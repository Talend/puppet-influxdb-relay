#
# == Define: influxdb_relay::configure::udp
#
# This definition provides a setup for udp configuration (https://github.com/influxdata/influxdb-relay)
#
# === Parameters
#
#  [*udp_name*]            - (string) Name of the UDP server, used for display purposes only (default $::fqdn)
#
#  [*udp_bind_address*]    - (string) UDP address to bind to (default 0.0.0.0)
#
#  [*udp_bind_port*]       - (integer) UDP port to bind to (default 9096)
#
#  [*udp_read_buffer*]     - (integer) Socket buffer size for incoming connections (default 0)
#
#  [*udp_precision*]       - (string) Precision to use for timestamps, Can be n, u, ms, s, m, h (default n)
#
#  [*udp_outputs*]         - (array of hash) configuration for udp outputs (example):
#                             [
#                               { name="server1", location="192.168.0.10:8089", mtu=1024 },
#                               { name="server2", location="192.168.0.12:8089", mtu=1024 },
#                             ]
#                             this option is mutually exclusive with *udp_output_servers* and win if both are present
#
#  [*udp_output_servers*]  - (array of string) basic configuration for udp outputs using defaults (example):
#                             [ "192.168.0.10:8089", "192.168.0.12:8089" ]
#                             this option is mutually exclusive with *udp_outputs* and is ignored if both are present
#
define influxdb_relay::configure::udp (
  $udp_name           = $title,
  $udp_bind_address   = $::influxdb_relay::params::udp_bind_address,
  $udp_bind_port      = $::influxdb_relay::params::udp_bind_port,
  $udp_read_buffer    = $::influxdb_relay::params::udp_read_buffer,
  $udp_precision      = $::influxdb_relay::params::udp_precision,
  $udp_outputs        = {},
  $udp_output_servers = []
) {
  concat::fragment{ "influxdb-relay-udp-${title}":
    target  => $::influxdb_relay::params::configuration_file,
    content => template('influxdb_relay/udp_config.toml.erb'),
    notify  => Service['influxdb-relay'],
  }
}
