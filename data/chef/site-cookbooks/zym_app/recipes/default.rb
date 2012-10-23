#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
application "#{node[:zym_app][:domain]}" do
  path node[:zym_app][:release_dir]
  owner node[:zym_app][:user]
  group node[:zym_app][:group]

  repository node[:zym_app][:repository]
  revision node[:zym_app][:revision]
  deploy_key node[:zym_app][:deploy_key]
end