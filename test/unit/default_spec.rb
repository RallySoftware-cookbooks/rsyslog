require_relative 'spec_helper'

describe 'rsyslog::default' do
  let(:disable_syslog) { false }
  subject(:chef_run) do
    ChefSpec::Runner.new do |node|
      if disable_syslog
        node.automatic_attrs[:platform_family] = 'rhel'
        node.automatic_attrs[:version] = '5.8'
      end
      node.set[:rsyslog][:server_name] = '1.2.3.4'
    end.converge described_recipe
  end

  it { should install_package 'rsyslog' }

  it { should create_directory('/etc/rsyslog.d').with(owner: 'root', group: 'root', mode: '0755') }

  it { should start_service 'rsyslog' }

  it { should enable_service 'rsyslog' }

  describe 'disables syslog service when below version 6 on rhel' do
    let(:disable_syslog) { true }

    it { should stop_service 'syslog' }
    it { should disable_service 'syslog' }
  end
end
