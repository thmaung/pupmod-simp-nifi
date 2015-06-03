require 'spec_helper'

describe 'nifi' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "nifi class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('nifi::params') }
          it { is_expected.to contain_class('nifi::install').that_comes_before('nifi::config') }
          it { is_expected.to contain_class('nifi::config') }
          it { is_expected.to contain_class('nifi::service').that_subscribes_to('nifi::config') }

          it { is_expected.to contain_service('nifi') }
          it { is_expected.to contain_package('nifi').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'nifi class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('nifi') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
