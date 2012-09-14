if !node.attribute?("vagrant") 
  db_server = search(:node, 'role:database')
end

template "#{node[:zym_app][:dir]}/config/db.xml" do
  source "db.xml.erb"
  mode 0755
  owner node[:apache][:user]
  group node[:apache][:group]
  variables({
    :db => {
      :default => {
        :driver   => "pdo_mysql",
        :host     => "127.0.0.1",
        :name     => node[:zym_app][:domain],
        :user     => "root",
        :password => ""
      }
    }

  })
end

include_recipe "composer"

composer "#{node[:zym_app][:dir]}" do
  action [:deploy, :install]
end
  
if Chef::Config[:solo]
  symfony2_console "Drop database" do
    action :cmd
  
    command "doctrine:database:drop --force"
  
    path node[:zym_app][:dir]
  end
  
  symfony2_console "Create database" do
    action :cmd

    command "doctrine:database:create"

    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end

  symfony2_console "Create schema" do
    action :cmd

    command "doctrine:schema:create"

    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end

  symfony2_console "Load fixtures" do
    action :cmd

    command "doctrine:fixtures:load"

    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end
  
  symfony2_console "Clear Cache" do
    action :cmd
  
    command "cache:clear"
  
    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end
  
  symfony2_console "Clear Cache" do
    action :cmd
  
    command "cache:clear"
  
    path node[:zym_app][:dir]
    env "prod"
    debug false
  end

  symfony2_console "Install assets" do
    action :cmd

    command "assets:install"

    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end

  symfony2_console "Assetic dump" do
    action :cmd

    command "assetic:dump"

    path node[:zym_app][:dir]
    env node[:zym_app][:environment]
    debug node[:zym_app][:debug]
  end
end