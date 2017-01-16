#
# == Class: influxdb_relay::repositories::apt
#
# This class manage the installation of apt repository for influxdb-relay
#
class influxdb_relay::repositories::apt {

  $downcaseos = downcase($::operatingsystem)

  apt::source { 'repos.influxdata.com':
    location    => "https://repos.influxdata.com/${downcaseos}",
    release     => $::lsbdistcodename,
    repos       => 'stable',
    key         => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
    key_source  => 'https://repos.influxdata.com/influxdb.key',
    include_src => false,
    before      => Package['influxdb-relay'],
  }
}
