# == Class: contrail
#
# This class to setup opencontrail.
#
# === Parameters
#
# [*manage_rabbitmq*]
#    Whether to manage rabbitmq in the module
#
# [*manage_zookeeper*]
#    Whether to manage zookeeper in this module
#
# [*zookeeper_server_id*]
#    A Unique id of zookeeper server within the cluster
#
#
# === Examples
#
#  include  contrail
#
# === Authors
#
# Harish Kumar <hkumar@d4devops.org>
#
#

class contrail (
  $manage_rabbitmq       = true,
  $rabbitmq_manage_repo = false,
  $rabbitmq_admin_enable = false,
  $manage_zookeeper    = true,
  $zookeeper_server_id = 1,
) {

  ##
  ## Declaring anchors
  ##
  anchor {'contrail::start':}
  anchor {'contrail::end_base_services':
    before  => Anchor['contrail::end'],
    require => Anchor['contrail::start'],
  }
  anchor {'contrail::end':}


  ##
  ## contrail::system_config does operating system parameter changes,
  ##       and make the system ready to run contrail services
  ##

  include ::contrail::system_config
  Anchor['contrail::start'] -> Class['contrail::system_config'] -> Anchor['contrail::end_base_services']

  ##
  ## sometimes existing rabbitmq server/cluster would be used
  ##

  if $manage_rabbitmq {

    class {'::rabbitmq':
      manage_repos => $rabbitmq_manage_repo,
      admin_enable => $rabbitmq_admin_enable,
    }

    Anchor['contrail::start'] -> Class['::rabbitmq'] -> Anchor['contrail::end_base_services']
  }

  ##
  ##  setup zookeeper if enabled
  ##

  if $manage_zookeeper {
    class {'contrail::zookeeper':
      server_id => $zookeeper_server_id,
    }

    Anchor['contrail::start'] -> Class['contrail::zookeeper'] -> Anchor['contrail::end_base_services']
  }

}
