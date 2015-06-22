# == Class nifi::config
#
# This class is called from nifi for service config.
#
class nifi::config (
  $global_owner            = $::nifi::params::global_owner,
  $global_group            = $::nifi::params::global_group,

  $nifi_home               = $::nifi::params::nifi_home,
  $conf_template           = 'nifi/conf/nifi.properties.erb',
  $bootstrap_template      = 'nifi/conf/bootstrap.conf.erb',

  $security_limits_file    = $::nifi::params::security_limits_file,
  $is_ncm                  = $::nifi::params::is_ncm,
  $cluster_mode            = $::nifi::params::cluster_mode,

  $java_xms                = $::nifi::params::java_xms,
  $java_xmx                = $::nifi::params::java_xmx,

  $flow_file               = $::nifi::params::flow_file,
  $flow_archive_dir        = $::nifi::params::flow_archive_dir,
  $flow_autoresume         = $::nifi::params::flow_autoresume,
  $banner_text             = $::nifi::params::banner_text,

) inherits ::nifi::params {
  
  validate_string($banner_text)

  File {
    owner => $global_owner,
    group => $global_group,
    mode  => $global_mode,
  }

  file { $service_file:
    ensure   => file,
    owner    => 'root',
    group    => 'root',
    mode     => '0755',
    content  => template('nifi/service/nifi.erb'),
    notify   => Service['nifi'],
  }

  file { "${nifi_home}/${conf_dir}":
    ensure => directory,
  }

  file { "${nifi_home}/${conf_dir}/nifi.properties":
    ensure  => file,
    content => template($conf_template),
  } 
  
  file { "${nifi_home}/${conf_dir}/bootstrap.conf":
    ensure  => file,
    content => template($bootstrap_template),
  } 
  
  unless $is_ncm {
    ## Handle Ulimits: 
  }
}
