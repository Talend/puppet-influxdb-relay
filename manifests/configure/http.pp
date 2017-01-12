#
# == Define: influxdb_relay::configure::http
#
# This definition provides a setup for http configuration (https://github.com/influxdata/influxdb-relay)
#
# === Parameters
#
#  [*http_name*]            - (string) Name of the HTTP server, used for display purposes only (default $::fqdn)
#
#  [*http_bind_address*]    - (string) TCP address to bind to, for HTTP server (default 0.0.0.0)
#
#  [*http_bind_port*]       - (integer) TCP port to bind to, for HTTP server (default 9096)
#
#  [*http_ssl_enable*]      - (boolean) Enable HTTPS requests
#
#  [*http_ssl_pem*]         - (boolean) ssl pem path (/etc/ssl/influxdb-relay.pem)
#
#  [*http_default_retention_policy*]  - (string) undocumented, use it at your own risk (default, not used)
#
#  [*http_outputs*]         - (array of hash) configuration for http outputs (example):
#
#                               { name="server1", location="http://192.168.0.10:8086/write", timeout="10s", buffer-size-mb=0, max-batch-kb=512, max-delay-interval="10s", skip-tls-verification="false" },
#                               { name="server2", location="http://192.168.0.12:8086/write", timeout="10s", buffer-size-mb=0, max-batch-kb=512, max-delay-interval="10s", skip-tls-verification="false" }
#                             ]
#                             this option is mutually exclusive with *http_output_servers* and win if both are present
#
#  [*http_output_servers*]  - (array of string) basic configuration for http outputs using defaults (example):
#                             [ "192.168.0.10:8086", "192.168.0.12:8086" ]
#                             this option is mutually exclusive with *http_outputs* and is ignored if both are present
#
define influxdb_relay::configure::http (
  $http_name                     = $title,
  $http_bind_address             = $::influxdb_relay::params::http_bind_address,
  $http_bind_port                = $::influxdb_relay::params::http_bind_port,
  $http_ssl_enable               = $::influxdb_relay::params::http_ssl_enable,
  $http_ssl_pem                  = $::influxdb_relay::params::http_ssl_pem,
  $http_default_retention_policy = $::influxdb_relay::params::http_default_retention_policy,
  $http_outputs                  = {},
  $http_output_servers           = [],
) {
  concat::fragment{ "influxdb-relay-http-${title}":
    target  => $::influxdb_relay::params::configuration_file,
    content => template('influxdb_relay/http_config.toml.erb'),
    notify  => Service['influxdb-relay'],
  }
}
