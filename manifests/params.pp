# == Class nifi::params
#
# This class is meant to be called from nifi.
# It sets variables according to platform.
#
class nifi::params {
  case $::osfamily {
    'Debian': {
      $package_name         = 'nifi'
      $service_name         = 'nifi'
      $security_limits_file = '/etc/security/limits.conf'
    }
    'RedHat', 'Amazon': {
      $package_name         = 'nifi'
      $service_name         = 'nifi'
      $security_limits_file = '/etc/security/limits.conf'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  ## Referenced Variables
  $global_user          = 'root'
  $global_group         = 'root'
  $global_mode          = '0640'

  $conf_dir             = '/opt/nifi/default/conf'
  $lib_dir              = '/opt/nifi/default/lib'
  $is_ncm               = false
  $cluster_mode         = false

  ## Bootstrap Configurations
  $java_xms             = '256MB'
  $java_xmx             = '512MB'

  ## Core Configuration settings
  $banner_text          = 'TODO: OP NIFI MODULE'
  $flow_file            = './conf/flow.xml.gz'
  $flow_archive_dir     = './conf/archive/'
  $flow_autoresume      = 'true'
}
