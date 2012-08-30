#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node[:mysql][:confd_dir]}/charset.cnf" do
  source "charset.cnf.erb"
  variables(
    :encoding => node[:zym_app][:mysql][:encoding],
    :collation => node[:zym_app][:mysql][:collation]
  )
end