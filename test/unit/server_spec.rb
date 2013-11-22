require_relative 'spec_helper'

describe 'rsyslog::server' do
  let(:sysconfig_file) { '/etc/sysconfig/rsyslog' }

 subject(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:rsyslog][:server_name] = '1.2.3.4'
    end.converge described_recipe
  end

  it { should create_template(sysconfig_file).with(owner: 'root', group: 'root', mode: '0644') }

  it { should render_file(sysconfig_file).with_content('-r') }
end
