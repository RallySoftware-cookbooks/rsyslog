require_relative 'spec_helper'

describe 'rsyslog::server' do
  SYSCONFIG_FILE = '/etc/sysconfig/rsyslog'

  before (:all) do
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set['rsyslog']['server_name'] = '1.2.3.4'
    @chef_run.converge 'rsyslog::server'
  end

  it "should create #{SYSCONFIG_FILE} with proper permissions" do
    expect(@chef_run).to create_file SYSCONFIG_FILE
    file = @chef_run.template(SYSCONFIG_FILE)
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq(0644)
  end

  it "should create #{SYSCONFIG_FILE} with proper content" do
    expect(@chef_run).to create_file_with_content(SYSCONFIG_FILE, '-r')
  end
end
