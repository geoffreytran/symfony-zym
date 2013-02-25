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

# Create cache.xml
template "#{node[:zym][:dir]}/config/cache.xml" do
  source "cache.xml.erb"
  mode 0775
  owner node[:apache][:user]  if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables({
    :host => "127.0.0.1",
    :port => "11211"
  })

  if cookbook
    cookbook cookbook
  end
end

# Create queue.xml
template "#{node[:zym][:dir]}/config/queue.xml" do
  source "queue.xml.erb"
  mode 0775
  owner node[:apache][:user]  if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables({
    :host     => "127.0.0.1",
    :port     => "6379",
    :database => "0"
  })

  if cookbook
    cookbook cookbook
  end
end

# Create cdn.xml
cdn = {
  :rackspace => {
    :container => "",
    :user      => "",
    :api_key   => ""
  }
}
cdn = Chef::Mixin::DeepMerge.merge(cdn, node[:zym][:cdn])

template "#{node[:zym][:dir]}/config/cdn.xml" do
  source "cdn.xml.erb"
  mode 0775
  owner node[:apache][:user]  if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables(cdn)

  if cookbook
    cookbook cookbook
  end
end

# Create mail.xml
mail = {
  :transport  => 'mail',
  :encryption => '',
  :auth_mode  => '',
  :host       => '127.0.0.1',
  :port       => 'false',
  :username   => '',
  :password   => ''
}
mail = Chef::Mixin::DeepMerge.merge(mail, node[:zym][:mail])

template "#{node[:zym][:dir]}/config/mail.xml" do
  source "mail.xml.erb"
  mode 0775
  owner node[:apache][:user]  if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables(mail)
end

# Create parameters.ini
parameters = {
  :app => {
    :name           => 'Untitled Symfony App',
    :normalizedName => 'symfony-zym'
  },

  :assetic => {
    :less => {
      :node_bin   => "#{node[:nodejs][:dir]}/bin/node",
      :node_paths => "#{node[:nodejs][:dir]}/lib/node_modules"
    }
  },

  :assets => {
    :version => node[:zym][:revision][0..4]
  },

  :kernel => {
    :trusted_proxies => ['127.0.0.1']
  },

  :other => {

  }
}
parameters = Chef::Mixin::DeepMerge.merge(parameters, node[:zym][:parameters])

template "#{node[:zym][:dir]}/config/parameters.ini" do
  source "parameters.ini.erb"
  mode 0775
  owner node[:apache][:user]  if not Chef::Config[:solo]
  group node[:apache][:group] if not Chef::Config[:solo]
  variables(parameters)
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
    env   "prod" # node[:zym][:environment]
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

  database_exists = Chef::ShellOut.new(
    "mysql -u#{node[:zym][:db][:user]} -p#{node[:zym][:db][:password]} -h #{mysql_host} -e'use #{node[:zym][:db][:name]}; show tables;'",
    :env   => { 'PATH' => '/usr/bin:/usr/local/bin:/bin:/sbin' }
  )
  database_exists.run_command

  if not database_exists.run_command.stdout.include?("Empty set")
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
end
