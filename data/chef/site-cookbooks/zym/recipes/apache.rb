#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

apache_site "default" do
  enable false
end

zym_apache "#{node[:zym][:domain]}" do
  dir            node[:zym][:dir]
  domain_aliases node[:zym][:domain_aliases]
  environment    node[:zym][:environment]
end