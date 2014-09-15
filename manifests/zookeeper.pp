##
## Class: contrail::zookeeper
##    Manage Apache zookeeper
##
## == Parameters
##
## [*server_id*]
##    A unique id of zookeeper server, within the cluster.
##

class contrail::zookeeper (
  $server_id = 1,
) {

  ##
  ## install java
  ##

  include java

  ##
  ## Call zookeeper
  ## In case of contrail cluster ( 3 node), server_id will be different.
  ##

  class {'::zookeeper':
    id => $server_id,
  }
}
