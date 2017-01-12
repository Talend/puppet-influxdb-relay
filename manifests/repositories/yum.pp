#
# == Class: influxdb_relay::repositories::yum
#
# This class manage the installation of yum repository
#
class influxdb_relay::repositories::yum {

  $oscode = $::operatingsystem ? {
    'CentOS' => downcase($::operatingsystem),
    default  => 'rhel',
  }

  yumrepo { 'repos.influxdata.com':
    descr    => "InfluxDB Repository - ${::operatingsystem} \$releasever",
    baseurl  => "https://repos.influxdata.com/${oscode}/\$releasever/\$basearch/stable",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'https://repos.influxdata.com/influxdb.key',
    before   => Package['influxdb-relay'],
  }
}
