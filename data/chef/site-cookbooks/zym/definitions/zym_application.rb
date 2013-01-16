define :zym_application, :mail => {}, :parameters => {}, :cookbook => "zym" do
  include_recipe "zym::php"
  include_recipe "composer"
  
  application "#{params[:name]}" do
    path  params[:release_dir]
    owner params[:user]
    group params[:group]
  
    repository params[:repository]
    revision   params[:revision]
    deploy_key params[:deploy_key]
  
    migrate true
    migration_command "echo 'hi'"
  
    if params[:force_deploy]
      action :force_deploy
    end
    
    before_migrate do
      db_server  = search(:node, @new_resource.params[:db_server_query])
      mysql_host = db_server[0]['mysql']['bind_address']
      
      database = @new_resource.params[:database]
      cookbook = @new_resource.params[:cookbook]
      
      template "#{release_path}/config/db.xml" do
        source "db.xml.erb"
        mode 0775
        owner node[:apache][:user]  if not Chef::Config[:solo]
        group node[:apache][:group] if not Chef::Config[:solo]
        variables({
          :db => {
            :default => {
              :driver   => "pdo_mysql",
              :host     => mysql_host,
              :name     => database[:name],
              :user     => database[:user],
              :password => database[:password]
            }
          }
      
        })
        
        if cookbook
          cookbook cookbook
        end
      end
      
      cache_server = search(:node, @new_resource.params[:cache_server_query])
      template "#{release_path}/config/cache.xml" do
        source "cache.xml.erb"
        mode 0775
        owner node[:apache][:user]  if not Chef::Config[:solo]
        group node[:apache][:group] if not Chef::Config[:solo]
        variables({
          :host => cache_server[0]['cloud']['local_ipv4'],
          :port => cache_server[0]['memcached']['port']
        })
        
        if cookbook
          cookbook cookbook
        end
      end

      mail = {
        :transport  => 'mail',
        :encryption => '',
        :auth_mode  => '',
        :host       => '127.0.0.1',
        :port       => 'false',
        :username   => '',
        :password   => ''
      }
      mail = Chef::Mixin::DeepMerge.merge(mail, @new_resource.params[:mail])
      template "#{release_path}/config/mail.xml" do
        source "mail.xml.erb"
        mode 0775
        owner node[:apache][:user]  if not Chef::Config[:solo]
        group node[:apache][:group] if not Chef::Config[:solo]
        variables(mail)
        
        if cookbook
          cookbook cookbook
        end
      end
      
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
          :version => @new_resource.params[:revision][0..4]
        },
        :other => {
          
        }
      }
      parameters = Chef::Mixin::DeepMerge.merge(parameters, @new_resource.params[:parameters])
      
      
      template "#{release_path}/config/parameters.ini" do
        source "parameters.ini.erb"
        mode 0775
        owner node[:apache][:user]  if not Chef::Config[:solo]
        group node[:apache][:group] if not Chef::Config[:solo]
        variables(parameters)
        
        if cookbook
          cookbook cookbook
        end
      end
            
      composer "#{release_path}" do
        action [:deploy, :install]
      end
      
      environment = @new_resource.params[:environment]
      debug       = @new_resource.params[:debug]
      
      symfony2_console "Clear Cache" do
        action :cmd
      
        command "cache:clear"
      
        path  release_path
        env   environment
        debug debug
      end
      
      symfony2_console "Install assets" do
        action :cmd
      
        command "assets:install"
      
        path  release_path
        env   environment
        debug debug
      end
      
      symfony2_console "Assetic dump" do
        action :cmd
      
        command "assetic:dump"
      
        path  release_path
        env   environment
        debug debug
      end
    end
  end  
end