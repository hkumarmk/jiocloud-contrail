#
# Class: contrail::params
#
class contrail::params {
  ##
  ## Contrail configs
  ##

  $control_ip_list             = [$::ipaddress]

  ##
  ## Rabbitmq
  ##

  $manage_rabbitmq             = true
  $rabbitmq_manage_repo        = false
  $rabbitmq_admin_enable       = false

  ##
  ##  Zookeeper
  ##

  $manage_zookeeper            = true
  $zookeeper_server_id         = 1

  ##
  ## Haproxy
  ##

  $manage_haproxy              = true

  ##
  ## Cassandra
  ##

  $manage_cassandra            = true
  $cassandra_seeds             = [$::ipaddress]
  $cassandra_cluster_name      = 'contrail'
  $cassandra_thread_stack_size = 300
  $cassandra_version           = '1.2.18-1'
  $cassandra_package_name      = 'dsc12'

  ##
  ## Redis
  ##

  $manage_redis                = true
}

