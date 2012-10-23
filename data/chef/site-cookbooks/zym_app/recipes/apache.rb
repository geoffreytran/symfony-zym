#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node.has_key?("cloud")
  server_fqdn = node[:cloud][:public_hostname]
else
  server_fqdn = node[:fqdn]
end

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "#{node[:zym_app][:domain]}" do
  template "apache-site.conf.erb"
  docroot "#{node[:zym_app][:dir]}/web"
  server_name node[:zym_app][:domain]
  server_aliases ["www.#{node[:zym_app][:domain]}", node[:fqdn], node[:hostname]]
end
