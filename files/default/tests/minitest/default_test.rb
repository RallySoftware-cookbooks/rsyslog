require File.expand_path('../support/helpers', __FILE__)

describe 'rsyslog::default' do

  include Helpers::Rsyslog

  it 'should install rsyslog package' do
    package('rsyslog').must_be_installed
  end

  it 'should start the rsyslog service' do
    service('rsyslog').must_be_running
  end
end
