require 'chefspec'

describe 'rsyslog::forward' do

  FORWARD_FILE_NAME = '/etc/rsyslog.d/20-forward.conf'
  before(:all) do
    @chef_run = ChefSpec::ChefRunner.new
    @chef_run.node.set['rsyslog']['server_name'] = '1.2.3.4'
    @chef_run.converge('rsyslog::forward')

    @file = @chef_run.template(FORWARD_FILE_NAME)
  end

  it 'should log an error when server_name is missing' do
    puts '**** This test is intended to provoke a Recipe Compile Error => RuntimeError ****'
    lambda { ChefSpec::ChefRunner.new.converge('rsyslog::forward') }.should raise_error('Unable to determine rsyslog server name, please add proper attributes')
    puts '**** Exceptions after this test ^ are a problem! ****'
  end

  it "should create #{FORWARD_FILE_NAME}" do
    expect(@chef_run).to create_file(FORWARD_FILE_NAME)
  end

  it "should create #{FORWARD_FILE_NAME} with proper permissions" do
    expect(@file.mode).to eq(0644)
  end

  it "should create #{FORWARD_FILE_NAME} with correct owner" do
    expect(@file).to be_owned_by('root', 'root')
  end

  it 'should restart the rsyslog service' do
    expect(@file).to notify('service[rsyslog]', 'restart')
  end
end
