
describe file('/etc/sysconfig/rsyslog') do
  it { should be_file }
  its('mode') { should cmp '00644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
