##
## Class: contrail::haproxy::services
##    configure haproxy load balanced services for contrail
##

class contrail::haproxy::services(
  $vip                            = '0.0.0.0',
  $neutron_vip                    = undef,
  $neutron_backend_ips            = [$::ipaddress],
  $contrail_api_server_vip        = undef,
  $contrail_api_backend_ips       = [$::ipaddress],
  $contrail_discovery_server_vip  = undef,
  $contrail_discovery_backend_ips = [$::ipaddress],
) {

  if $neutron_vip {
    $neutron_vip_orig = $neutron_vip
  } else {
    $neutron_vip_orig = $vip
  }

  if $contrail_api_server_vip {
    $contrail_api_vip_orig = $contrail_api_server_vip
  } else {
    $contrail_api_vip_orig = $vip
  }

  if $contrail_discovery_server_vip {
    $contrail_discovery_vip_orig = $contrail_discovery_server_vip
  } else {
    $contrail_discovery_vip_orig = $vip
  }


  contrail::haproxy::member { 'neutron':
    vip              => $neutron_vip_orig,
    listen_ports     => 9696,
    balancer_ports    => '9697',
    cluster_addresses => $neutron_backend_ips,
  }

  contrail::haproxy::member { 'contrail_api':
    vip              => $contrail_api_vip_orig,
    listen_ports     => 8082,
    balancer_ports    => 9100,
    cluster_addresses => $contrail_api_backend_ips,
  }

  contrail::haproxy::member { 'contrail_discovery':
    vip              => $contrail_discovery_vip_orig,
    listen_ports     => 5998,
    balancer_ports    => '9110',
    cluster_addresses => $contrail_discovery_backend_ips,
  }
}
