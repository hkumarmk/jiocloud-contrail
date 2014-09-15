require 'spec_helper'

describe 'contrail::zookeeper' do
  let (:facts) { {
    :operatingsystem => 'Ubuntu',
    :osfamily        => 'Debian',
    :lsbdistid       => 'ubuntu',
    :lsbdistcodename => 'trusty'
  } }
  context 'with defaults' do
    it do
      should contain_class('zookeeper').with_id('1')
      should contain_class('java')
    end
  end

  context 'with server_id = 2' do
    let (:params) { { :server_id => 2 } }
    it { should contain_class('zookeeper').with_id('2') }
  end

end
