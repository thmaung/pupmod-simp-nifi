# == Class nifi::install
#
# This class is called from nifi for install.
#
class nifi::install {

  package { $::nifi::package_name:
    ensure => present,
  }
}
