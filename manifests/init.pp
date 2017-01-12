#
# == Class: influxdb_relay
#
# This class provides a setup for influxdb-relay (https://github.com/influxdata/influxdb-relay)
#
# === Parameters
#
#  [*manage_repo*]                     - (boolean) Manage repository or not
#
#  [*version*]                         - (string) package version to install (default present)
#
#  [*default_http_name*]               - (string) default prefix for http configuration if name for listener if not given in ressource
#
#  [*default_http_timeout*]            - (string) default http timeout for listener, default, not defined => influxdb-relay management)
#
#  [*default_http_buffer_size_mb*]     - (integer) default http buffer size (mb) (default, not defined => influxdb-relay management)
#
#  [*default_http_max_batch_kb*]       - (integer) default http max batch size (kb) (default, not defined => influxdb-relay management)
#
#  [*default_http_max_delay_interval*] - (string) default http max delay interval (default, not defined => influxdb-relay management)
#
#  [*default_http_skip_tls_verification*]- (boolean) default http skip tls verification (default, not defined => influxdb-relay management)
#
#  [*http_configurations*]             - (array of hash) used for create ressources of influx_dbrelay::configure::http (default empty)
#
#  [*default_udp_name*]                - (string) default prefix for udp configuration if name for listener if not given in ressource
#
#  [*default_udp_mtu*]                 - (string) default udp mtu (default, not defined => influxdb-relay management)
#
#  [*udp_configurations*]              - (array of hash) used for create ressources of influx_dbrelay::configure::udp (default empty)
#
#  [*ensure_service*]                  - desired service state (default running)
#
class influxdb_relay (
  $manage_repo                        = $::influxdb_relay::params::manage_repo,
  $version                            = $::influxdb_relay::params::version,
  $default_http_name                  = $::influxdb_relay::params::default_http_name,
  $default_http_timeout               = $::influxdb_relay::params::default_http_timeout,
  $default_http_buffer_size_mb        = $::influxdb_relay::params::default_http_buffer_size_mb,
  $default_http_max_batch_kb          = $::influxdb_relay::params::default_http_max_batch_kb,
  $default_http_max_delay_interval    = $::influxdb_relay::params::default_http_max_delay_interval,
  $default_http_skip_tls_verification = $::influxdb_relay::params::default_http_skip_tls_verification,
  $http_configurations                = {},
  $default_udp_name                   = $::influxdb_relay::params::default_udp_name,
  $default_udp_mtu                    = $::influxdb_relay::params::default_udp_mtu,
  $udp_configurations                 = {},
  $ensure_service                     = $::influxdb_relay::params::ensure_service
) inherits influxdb_relay::params {
  anchor { 'influxdb_relay::begin': } ->
  class { '::influxdb_relay::install': } ->
  class { '::influxdb_relay::configure': } ~>
  class { '::influxdb_relay::service': } ->
  anchor { 'influxdb_relay::end': }
}
