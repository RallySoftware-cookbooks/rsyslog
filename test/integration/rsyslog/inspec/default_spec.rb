
describe file('/etc/rsyslog.d') do
  it { should be_directory }
  its('mode') { should cmp '00755' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service('syslog') do
  it { should_not be_enabled }
  it { should_not be_running }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end
