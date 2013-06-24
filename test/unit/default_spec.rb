require_relative 'spec_helper'

describe 'rsyslog::default' do
  before(:all) do
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set['rsyslog']['server_name'] = '1.2.3.4'
    @chef_run.converge 'rsyslog::default'
  end

  it 'should install rsyslog package' do
    expect(@chef_run).to install_package 'rsyslog'
  end

  it 'should create /etc/rsyslog.d with proper permissions' do
    expect(@chef_run).to create_directory '/etc/rsyslog.d'
    directory = @chef_run.directory('/etc/rsyslog.d')
    expect(directory).to be_owned_by('root', 'root')
    expect(directory.mode).to eq(0755)
  end

  it 'should enable rsyslog service' do
    expect(@chef_run).to start_service 'rsyslog'
    expect(@chef_run).to set_service_to_start_on_boot 'rsyslog'
  end

  it 'should disable syslog service' do
    chef_centos5_run = ChefSpec::ChefRunner.new(platform: 'centos', version: '5.8').converge 'rsyslog::default'
    expect(chef_centos5_run).to stop_service 'syslog'
    expect(chef_centos5_run).to set_service_to_not_start_on_boot 'syslog'
  end
end
