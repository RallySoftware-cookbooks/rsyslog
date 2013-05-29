# rsyslog cookbook

# Requirements
Availability of rsyslog package via operating system package management system

# Usage
To configure rsyslog with the default ruleset, include rsyslog::default.

To configure rsyslog with the default ruleset forwarding to a remote server, include rsyslog::forward and set the default['rsyslog']['server_name'] attribute to the syslog server name or IP.

To configure rsyslog to allow for receiving events from remote hosts, include rsyslog::server

# Attributes
default['rsyslog']['server_name'] = remote syslog server name or IP
default['rsyslog']['server_port'] = remote syslog server port

# Recipes
rsyslog::default
rsyslog::forward
rsyslog::server

# Author

Author:: Rally Software Development Corp. (<eklein@rallydev.com>)
