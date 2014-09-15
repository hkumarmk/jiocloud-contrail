require 'spec_helper'

describe 'contrail' do
  let :facts do
    {
      :operatingsystem => 'Ubuntu',
      :osfamily        => 'Debian',
      :lsbdistid       => 'ubuntu',
      :lsbdistcodename => 'trusty',
      :ipaddress       => '10.1.1.1',
      :concat_basedir  => '/tmp',
      :processorcount  => 2,
    }
  end

  context 'with defaults' do
    it do
      should contain_class('contrail::system_config')
      should contain_class('rabbitmq').with({
        'manage_repos' => false,
        'admin_enable' => false
      })
      should contain_class('contrail::zookeeper').with_server_id('1')
      should contain_class('contrail::haproxy')
      should contain_class('contrail::haproxy::services').with({
        'neutron_backend_ips'        => '10.1.1.1',
        'contrail_api_backend_ips'   => '10.1.1.1',
        'contrail_discovery_backend_ips' => '10.1.1.1'
      })
     should contain_class('cassandra').with({
        'seeds'          => ['10.1.1.1'],
        'cluster_name'   => 'contrail',
     })
    end
  end

  context 'with rabbitmq params' do
    context 'when rabbitmq disabld' do
      let (:params) { { :manage_rabbitmq => false } }
      it { should_not contain_class('rabbitmq') }
    end
    context 'when rabbitmq repos and admin enabled' do
      let (:params) { { :rabbitmq_manage_repo => true, :rabbitmq_admin_enable => true } }
      it do
        should contain_class('rabbitmq').with({
          'manage_repos' => true,
          'admin_enable' => true
        })
      end
    end
  end

  context 'with zookeeper params' do
    context 'when zookeeper server id is 3' do
      let (:params) { { :zookeeper_server_id => 3 } }
      it { should contain_class('contrail::zookeeper').with_server_id('3') }
    end
    context 'when zookeeper disabled' do
      let (:params) { { :manage_zookeeper => false } }
      it { should_not contain_class('contrail::zookeeper') }
    end
  end

  context 'with cassandra params' do
    context 'when cassandra_seeds and cluster name set' do
      let (:params) { { 
        :cassandra_seeds        => ['10.1.1.1','10.1.1.2'],
        :cassandra_cluster_name => 'testcluster',
      } }
      it { should contain_class('cassandra').with({
        'seeds'          => ['10.1.1.1','10.1.1.2'],
        'cluster_name'   => 'testcluster',
      }) }
    end
    context 'when cassandra disabled' do
      let (:params) { { :manage_cassandra => false } }
      it { should_not contain_class('cassandra') }
    end
  end

  context 'with Haproxy params' do
    context 'with control_ip_list' do
      let (:params) { { :control_ip_list => ['10.1.1.1','10.1.1.2','10.1.1.3'] } }
      it { should contain_class('contrail::haproxy::services').with({
        'neutron_backend_ips'        => ['10.1.1.1','10.1.1.2','10.1.1.3'],
        'contrail_api_backend_ips'   => ['10.1.1.1','10.1.1.2','10.1.1.3'],
        'contrail_discovery_backend_ips' => ['10.1.1.1','10.1.1.2','10.1.1.3']
      }) }
    end
    context 'when haproxy disabled' do
      let (:params) { { :manage_haproxy => false } }
      it { should_not contain_class('contrail::haproxy') }
    end
  end
end
