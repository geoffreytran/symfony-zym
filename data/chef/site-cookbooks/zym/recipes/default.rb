#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

zym_application "#{node[:zym][:domain]}" do
  release_dir node[:zym][:release_dir]

  user  node[:zym][:user]
  group node[:zym][:group]

  environment node[:zym][:environment]
  debug       node[:zym][:debug]

  db_server_query "chef_environment:#{node.chef_environment} AND recipes:zym\\:\\:database"
  database node[:zym][:db]

  cache_server_query "chef_environment:#{node.chef_environment} AND recipes:zym\\:\\:cache"

  queue_server_query "chef_environment:#{node.chef_environment} AND recipes:zym\\:\\:queue"
  queue node[:zym][:queue]

  mail node[:zym][:mail]

  repository node[:zym][:repository]
  deploy_key node[:zym][:deploy_key]
  revision   node[:zym][:revision]

  if node[:zym][:force_deploy]
    force_deploy true
  end

  parameters node[:zym][:parameters]
end