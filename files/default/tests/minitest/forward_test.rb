require File.expand_path('../support/helpers', __FILE__)

describe 'rsyslog::forward' do

  include Helpers::Rsyslog

  it 'should create /etc/rsyslog.d/20-forward.conf' do
    assert_file '/etc/rsyslog.d/20-forward.conf', 'root', 'root', '644'
  end

  it 'should create /etc/rsyslog.d/20-forward.conf with the proper content' do
    file = File.open('/etc/rsyslog.d/20-forward.conf')
    assert_includes_content(file, '*.* @1.2.3.4:514')
  end
end
