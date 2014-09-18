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
# [*manage_haproxy*]
#   Whether to manage haproxy in this module
#
# [*control_ip_list*]
#   An array of contrail control node IP list
#
# [*manage_cassandra*]
#    Whether to manage cassandra in this module
#
# [*manage_redis*]
#    Whteher to manage redis in this module
#
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
  $manage_rabbitmq             = $contrail::params::manage_rabbitmq,
  $rabbitmq_manage_repo        = $contrail::params::rabbitmq_manage_repo,
  $rabbitmq_admin_enable       = $contrail::params::rabbitmq_admin_enable,
  $manage_zookeeper            = $contrail::params::manage_zookeeper,
  $zookeeper_server_id         = $contrail::params::zookeeper_server_id,
  $manage_haproxy              = $contrail::params::manage_haproxy,
  $control_ip_list             = $contrail::params::control_ip_list,
  $manage_cassandra            = $contrail::params::manage_cassandra,
  $cassandra_seeds             = $contrail::params::cassandra_seeds,
  $cassandra_cluster_name      = $contrail::params::cassandra_cluster_name,
  $cassandra_thread_stack_size = $contrail::params::cassandra_thread_stack_size,
  $cassandra_version           = $contrail::params::cassandra_version,
  $cassandra_package_name      = $contrail::params::cassandra_package_name,
  $manage_redis                = $contrail::params::manage_redis,
) inherits contrail::params {

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
    ##
    ## Need to have atleast below heiradata
    ## rabbitmq::manage_repos: no
    ## rabbitmq::admin_enable: no
    ## This is the setup with contrail, may need to test without above setting true
    ##

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

  ##
  ## Sometimes people may use existing load balancer to load balance contrail services too.
  ##
  ## contrail::haproxy::services accept below parameters
  ##

  if $manage_haproxy {
    include contrail::haproxy
    class { 'contrail::haproxy::services':
      neutron_backend_ips            => $control_ip_list,
      contrail_api_backend_ips       => $control_ip_list,
      contrail_discovery_backend_ips => $control_ip_list,
    }
    Anchor['contrail::start'] -> Class['contrail::haproxy'] -> Class['contrail::haproxy::services'] -> Anchor['contrail::end_base_services']
  }

  ##
  ##  Setup cassandra
  ##  This assumes default configurations
  ##  Required Below mentioned Hiera data
  ##

  if $manage_cassandra {
    class { '::cassandra':
      seeds             => $cassandra_seeds,
      cluster_name      => $cassandra_cluster_name,
      thread_stack_size => $cassandra_thread_stack_size,
      version           => $cassandra_version,
      package_name      => $cassandra_package_name,
    }
    Anchor['contrail::start'] -> Class['::cassandra'] -> Anchor['contrail::end_base_services']
  }

  ##
  ## Manage redis if enabled.
  ##

  if $manage_redis {
    include ::redis

    Anchor['contrail::start'] -> Class['::redis'] -> Anchor['contrail::end_base_services']
  }

  ##
  ## Manage contrail ifmap
  ##
  class {'contrail::ifmap':
    control_ip_list => $control_ip_list
  }
}
