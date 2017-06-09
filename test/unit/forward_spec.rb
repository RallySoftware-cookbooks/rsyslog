require_relative 'spec_helper'

describe 'rsyslog::forward' do
  let(:forward_file_name) { '/etc/rsyslog.d/20-forward.conf' }
  let(:set_server_name) { true }

  subject(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
      node.normal['rsyslog']['server_name'] = '1.2.3.4'
    end.converge described_recipe
  end

  it 'creates /etc/rsyslog.d/20-forward.conf ' do
    expect(chef_run).to create_template(forward_file_name).with(
      owner: 'root',
      group: 'root',
      mode: '0644'
    )
  end

  describe 'forward_file' do
    subject { chef_run.template(forward_file_name) }
    it { should notify('service[rsyslog]').to(:restart) }
  end

  subject(:error_run) do
    ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
      node.normal['rsyslog']['server_name'] = nil
    end.converge described_recipe
  end
  context 'when node[:rsyslog][:server_name] is not set' do
    let(:set_server_name) { false }

    # specify { expect { error_run }.to raise_error(RuntimeError) }
  end
  it 'raises an error' do
    expect { error_run }.to raise_error(RuntimeError)
  end
end
