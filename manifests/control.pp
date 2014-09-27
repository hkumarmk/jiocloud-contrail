#
# Class contrail::control
#
class contrail::control (
 $package_ensure  = present, 
 $control_ip_list = [$::ipaddress],
 $config_ip       = $::ipaddress,
) {

  package {'contrail-control':
    ensure => $package_ensure,
  }

  ##
  # DNS configuration
  ##

  file { '/etc/contrail/dns.conf' :
    ensure  => present,
    content => template("${module_name}/dns.conf.erb"),
  }

  service {'contrail-dns':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/contrail/dns.conf'],
  }

  ##
  # control  configuration
  ##

  file { '/etc/contrail/contrail-control.conf' :
    ensure  => present,
    content => template("${module_name}/contrail-control.conf.erb"),
  }

  service {'contrail-control':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/contrail/contrail-control.conf'],
  }

}
