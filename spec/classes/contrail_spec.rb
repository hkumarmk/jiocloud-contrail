require 'spec_helper'

describe 'contrail' do
  let :facts do
    {
    :operatingsystem => 'Ubuntu',
    :osfamily        => 'Debian',
    :lsbdistid       => 'ubuntu',
    :lsbdistcodename => 'trusty'
    }
  end
  context 'with defaults' do
    it do
      should contain_class('contrail::system_config')
      should contain_class('rabbitmq').with({
        'manage_repos' => false,
        'admin_enable' => false
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
end
