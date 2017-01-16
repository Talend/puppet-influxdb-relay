# puppet-influxdb-relay #
Puppet module to manage influxdb-relay

## Example of use ##

See [example](examples/init.pp) and the correspoding [hierafile](hieradata/environment/vagrant.yaml)

## Testing ##
to test locally the Puppet module:

``` shell
./scripts/local_dev_tests.sh
```

To test only the centos version (debian can have troubles with generated packages):

``` shell
./scripts/local_dev_tests.sh -t influxdb-relay-centos-72
```

## Warning ##
influxdb-relay is not yet provided by influxdata inside their repository. So, for the moment, you have to manage yourself the repository to have something working. See [influxdata's documentation](https://github.com/influxdata/influxdb-relay) to build the packages.

There can be a problem with the debian package, example:
``` shell
dpkg: error processing archive /var/cache/apt/archives/influxdb-relay_adaa2ea-1_amd64.deb (--unpack):
 parsing file '/var/lib/dpkg/tmp.ci/control' near line 2 package 'influxdb-relay':
  error in 'Version' field string 'adaa2ea-1': version number does not start with digit
```
