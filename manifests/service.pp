# == Class nifi::service
#
# This class is meant to be called from nifi.
# It ensure the service is running.
#
class nifi::service {

  $service_file = $::nifi::params::service_file

  service { $::nifi::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File[$service_file],
  }
}
