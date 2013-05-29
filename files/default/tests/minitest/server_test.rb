require File.expand_path('../support/helpers', __FILE__)

describe 'rsyslog::server' do

  include Helpers::Rsyslog

  it 'should create /etc/sysconfig/rsyslog' do
    assert_file '/etc/sysconfig/rsyslog', 'root', 'root', '644'
  end

  it 'should create /etc/sysconfig/rsyslog with the proper content' do
    file = File.open('/etc/sysconfig/rsyslog')
    assert_includes_content(file, 'SYSLOGD_OPTIONS="-c 5 -r"')
  end
end
