name             'raven_collectd'
maintainer       'Raven Tools'
maintainer_email 'devops@raventools.com'
license          'All rights reserved'
description      'Installs/Configures raven_collectd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


recipe "raven_collectd::default", "Install and configure raven_collectd"

attribute "raven_collectd",
	:display_name => "Raven Collectd",
	:type => "hash"

attribute "raven_collectd/collectd_server",
	:display_name => "name or ip of collectd server",
	:description => "name or ip of collectd server",
	:required => "required",
	:type => "string",
	:recipes => ["raven_collectd::default"]

attribute "raven_collectd/collectd_port",
	:display_name => "collectd server port",
	:description => "collectd server port",
	:required => "required",
	:type => "string",
	:recipes => ["raven_collectd::default"]

	attribute "raven_collectd/hostname",
		:display_name => "host name for metrics",
		:description => "Hostname for metrics, will use this var, or ec2 instance_id , or server hostname",
		:required => "optional",
		:type => "string",
		:recipes => ["raven_collectd::default"]
