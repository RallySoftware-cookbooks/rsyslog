#
# Cookbook Name:: rsyslog
# Recipe:: default
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

package 'rsyslog'

directory '/etc/rsyslog.d' do
  action :create
  owner 'root'
  group 'root'
  mode 0755
end

# stop syslog service if we're running centos/oel/rhel 5.x
service 'syslog' do
  action [:stop, :disable]
  only_if { node['platform_family'] == 'rhel' && node['platform_version'].to_i < 6 }
end

service 'rsyslog' do
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
end
