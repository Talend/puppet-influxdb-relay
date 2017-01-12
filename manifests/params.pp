class influxdb_relay::params () {
  $manage_repo = true
  $configuration_file = '/etc/influxdb-relay/influxdb-relay.conf'
  $version = 'present'
  $http_name = $::fqdn
  $http_bind_address = '0.0.0.0'
  $http_bind_port = 9096
  $http_ssl_enable = false
  $http_ssl_pem = '/etc/ssl/influxdb-relay.pem'
  $http_default_retention_policy = undef
  $udp_name = $::fqdn
  $udp_bind_address = '0.0.0.0'
  $udp_bind_port = 8089
  $udp_read_buffer = 0
  $udp_precision = 'n'
  $ensure_service = 'running'

  #Default parameters for definitions #https://github.com/influxdata/influxdb-relay/blob/master/relay/config.go
  $default_http_name = 'influxdbhttp'
  $default_http_timeout = undef #10s
  $default_http_buffer_size_mb = undef #0
  $default_http_max_batch_kb = undef #512
  $default_http_max_delay_interval = undef #10s
  $default_http_skip_tls_verification = undef #false

  $default_udp_name = 'influxdbudp'
  $default_udp_mtu = undef #1024
}
