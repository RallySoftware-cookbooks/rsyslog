require_relative 'spec_helper'

describe 'rsyslog::forward' do
  let(:forward_file_name) { '/etc/rsyslog.d/20-forward.conf' }
  let(:set_server_name) { true }

  subject(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set[:rsyslog][:server_name] = '1.2.3.4' if set_server_name
    end.converge described_recipe
  end

  context 'when node[:rsyslog][:server_name] is not set' do
    let(:set_server_name) { false }

    specify { expect { chef_run }.to raise_error('Unable to determine rsyslog server name, please add proper attributes') }
  end

  it { should create_template(forward_file_name).with(owner: 'root', group: 'root', mode: '0644') }

  describe 'forward_file' do
    subject { chef_run.template(forward_file_name) }
    it { should notify('service[rsyslog]').to(:restart) }
  end
end
