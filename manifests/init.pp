# == Class: nifi
#
# Full description of class nifi here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class nifi (
  $package_name = $::nifi::params::package_name,
  $service_name = $::nifi::params::service_name,
) inherits ::nifi::params {

  # validate parameters here

  class { '::nifi::install': } ->
  class { '::nifi::config': } ~>
  class { '::nifi::service': } ->
  Class['::nifi']
}
