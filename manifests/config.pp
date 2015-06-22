# == Class nifi::config
#
# This class is called from nifi for service config.
#
class nifi::config (
  $global_owner   = $::nifi::params::global_owner,
  $global_group   = $::nifi::params::global_group,
  $banner_text    = $::nifi::params::banner_text,

  $conf_template  = 'nifi/conf/nifi.properties.erb',
) inherits ::nifi::params {
  
  validate_string($banner_text)

  File {
    owner => $global_owner,
    group => $global_group,
  }

  file { $conf_dir:
    ensure => directory,
  }

  file { "${conf_dir}/nifi.properties":
    ensure  => file,
    mode    => '0640',
    content => template($conf_template),
  } 
}
