#
# Cookbook Name:: rsyslog
# Recipe:: forward
#
# Copyright (c) Rally Software Development Corp. 2013
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe 'rsyslog::default'

if node['rsyslog']['server_name'].nil?
  raise 'Unable to determine rsyslog server name, please add proper attributes'
else
  template '/etc/rsyslog.d/20-forward.conf' do
    source '20-forward.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :server_name => node['rsyslog']['server_name'],
      :server_port => node['rsyslog']['server_port']
    )
    notifies :restart, 'service[rsyslog]', :delayed
  end
end
