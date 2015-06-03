# == Class nifi::params
#
# This class is meant to be called from nifi.
# It sets variables according to platform.
#
class nifi::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'nifi'
      $service_name = 'nifi'
    }
    'RedHat', 'Amazon': {
      $package_name = 'nifi'
      $service_name = 'nifi'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
