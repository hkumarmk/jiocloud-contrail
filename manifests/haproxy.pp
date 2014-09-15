##
## configure haproxy only if it is enabled
##   Sometimes people may use existing load balancer to load balance contrail services too
## TODO: There are number of parameters can be added to make this externally configurable.
##    all the parameters are hardcoded for now.
##

class contrail::haproxy {

  $haproxy_defaults = {
    'log'        => 'global',
    'mode'       => 'http',
    'option'     => ['httplog', 'dontlognull', 'redispatch'],
    'retries'    => '3',
    'maxconn'    => '2000',
    'timeout'    => ['connect 5000', 'client 10000', 'server 10000'],
    'errorfile' => [
                      '400 /etc/haproxy/errors/400.http',
                      '403 /etc/haproxy/errors/403.http',
                      '408 /etc/haproxy/errors/408.http',
                      '500 /etc/haproxy/errors/500.http',
                      '502 /etc/haproxy/errors/502.http',
                      '503 /etc/haproxy/errors/503.http',
                      '504 /etc/haproxy/errors/504.http'
                    ],
  }

  $haproxy_globals = {
    'log'       => '127.0.0.1 local0 notice',
    'maxconn'   => '4096',
    'user'      => 'haproxy',
    'group'     => 'haproxy',
    'daemon'    => '',
    'quiet'     => '',
    'stats'     => 'socket /var/run/haproxy mode 777',
  }

  class { '::haproxy':
    global_options   => $haproxy_globals,
    defaults_options => $haproxy_defaults
  }

  haproxy::listen { 'lb-stats':
    ipaddress => '0.0.0.0',
    ports     => '8084',
    mode      => 'http',
    options   => {
      'option'  => [
        'httplog',
      ],
      'stats' => ['enable', 'uri /lb-stats'],
    },
  }

}
