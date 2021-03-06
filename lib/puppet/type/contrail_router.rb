Puppet::Type.newtype(:contrail_router) do

  @doc = <<-'EOD'
  Provision contrail edge router objects on config server database.

  example:

  ## BElow code will provision an edge router.
  contrail_router {'router1':
    ensure => present,
    host_address => '10.1.1.10',
    admin_password => 'Chang3M3',
  }


  EOD

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Hostname of the node to be added.'
    munge do |v|
      v.strip
    end
  end

  newparam(:api_server_address) do
    desc 'Contrail api server address'
    defaultto '127.0.0.1'
    munge do |v|
      v.strip
    end
  end

  newparam(:api_server_port) do
    desc 'Contrail api server port'
    defaultto 8082
    newvalues(/^\d+$/)
    munge do |v|
      v.to_s
    end
  end

  newparam(:admin_user) do
    desc 'Keystone admin user name'
    defaultto 'admin'
    newvalues(/\S+/)
  end

  newparam(:admin_password) do
    desc 'Keystone admin user password'
  end

  newparam(:admin_tenant) do
    desc 'Keystone admin tenant name'
    defaultto 'openstack'
    newvalues(/\S+/)
  end

  newproperty(:host_address) do
    desc 'IP address of control node'
    munge do |v|
      v.strip
    end
  end

  newproperty(:router_asn) do
    desc 'router_asn is the AS number to be used, should match with the
      configuration on the external BGP speakers that you may want to use, by default
      64512 is used'
    defaultto 64512
    munge do |v|
      Integer(v)
    end
  end

  validate do
    raise(Puppet::Error, 'host_address is required') unless self[:host_address]
    raise(Puppet::Error, 'admin_password is required') unless self[:admin_password]
  end
end

