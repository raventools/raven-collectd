#
# Cookbook Name:: raven_collectd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/etc/yum.repos.d/raven.repo" do
    source "http://raven-pub-repo.s3-website-us-east-1.amazonaws.com/raven.repo"
	action :create_if_missing
end

package "raven-collectd"
package "raven-collectd-disk"


# create global config
if !node[:raven_collectd].attribute?(:hostname) then
	if !node.attribute?(:ec2) || !node[:ec2].attribute?(:instance_id) then
		hostname = node['hostname']
	else
		hostname = node[:ec2][:instance_id]
	end
else
    hostname = node[:raven_collectd][:hostname]
end

hostname = hostname.gsub!(/[^A-Za-z0-9_-]/,"_")
hostname = hostname.gsub!(/_+/,"_")
hostname = hostname.gsub!(/_-_/,"-")


template "/opt/raven-collectd/etc/collectd.conf" do
	source "collectd.conf.erb"
	variables ({
		:hostname => hostname,
		:collectd_server => node[:raven_collectd][:collectd_server],
		:collectd_port => node[:raven_collectd][:collectd_port]
	})
	notifies :restart, "service[raven-collectd]", :delayed
end


service "raven-collectd" do
    action [:start, :enable]
end
