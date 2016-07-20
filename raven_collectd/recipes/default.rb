#
# Cookbook Name:: raven_collectd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "raven-collectd"
package "raven-collectd-disk"



service "raven-collectd" do
    action [:start, :enable]
end
