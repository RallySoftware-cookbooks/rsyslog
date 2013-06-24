name             'rsyslog'
maintainer       'Rally Software Development Corp'
maintainer_email 'rallysoftware-cookbooks@rallydev.com'
license          'MIT'
description      'Installs/Configures rsyslog'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'rsyslog::default', 'Installs rsyslog'

supports 'ubuntu'
supports 'centos'
