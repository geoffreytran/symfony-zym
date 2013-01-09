mysql_host = "127.0.0.1"
mysql_user = "root"
mysql_pass = ""

template "#{node[:zym][:dir]}/config/db.xml" do
  source "db.xml.erb"
  mode 0775
  owner node[:apache][:user] if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables({
    :db => {
      :default => {
        :driver   => "pdo_mysql",
        :host     => mysql_host,
        :name     => node[:zym][:db][:name],
        :user     => node[:zym][:db][:user],
        :password => node[:zym][:db][:password]
      }
    }

  })
end

include_recipe "composer"

composer "#{node[:zym][:dir]}" do
  action [:deploy, :install]
end

if Chef::Config[:solo]
  symfony2_console "Clear Cache" do
    action :cmd

    command "cache:clear"

    path  node[:zym][:dir]
    env   node[:zym][:environment]
    debug node[:zym][:debug]
  end

  symfony2_console "Install assets" do
    action :cmd

    command "assets:install"

    path  node[:zym][:dir]
    env   node[:zym][:environment]
    debug node[:zym][:debug]
  end

  symfony2_console "Assetic dump" do
    action :cmd

    command "assetic:dump"

    path  node[:zym][:dir]
    #env   node[:zym][:environment]
    debug node[:zym][:debug]
  end

#  symfony2_console "Drop database" do
#    action :cmd
#
#    command "doctrine:database:drop --force"
#
#    path node[:zym][:dir]
#  end

#  symfony2_console "Create database" do
#    action :cmd
#
#    command "doctrine:database:create"
#
#    path  node[:zym][:dir]
#    env   node[:zym][:environment]
#    debug node[:zym][:debug]
#  end

  symfony2_console "Create schema" do
    action :cmd

    command "doctrine:schema:create"

    path  node[:zym][:dir]
    env   node[:zym][:environment]
    debug node[:zym][:debug]
  end

  symfony2_console "Load fixtures" do
    action :cmd

    command "doctrine:fixtures:load"

    path  node[:zym][:dir]
    env   node[:zym][:environment]
    debug node[:zym][:debug]
  end
end
