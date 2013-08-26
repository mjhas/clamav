require 'spec_helper'

describe 'clamav', :type => :class do
  let(:facts) { {:operatingsystem => 'Debian', :operatingsystemrelease => '7.1'} }
  it { should contain_package('clamav-daemon') }
  it { should contain_service('clamav-daemon') }
  it { should contain_package('clamav-freshclam') }
  it { should contain_service('clamav-freshclam') }
  context 'with milter => false' do
    let(:params) { {:milter => false} }

    it { should_not contain_package('clamav-milter') }
    it { should_not contain_service('clamav-milter') }
  end
  context 'with milter => true' do
    let(:params) { {:milter => true} }

    it { should contain_package('clamav-milter') }
    it { should contain_service('clamav-milter') }
  end
end

