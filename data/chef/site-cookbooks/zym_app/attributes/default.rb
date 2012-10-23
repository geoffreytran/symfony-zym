include_attribute "apache2"

default[:zym_app][:user]        = node[:apache][:user]
default[:zym_app][:group]       = node[:apache][:group]
default[:zym_app][:domain]      = node[:fqdn]
default[:zym_app][:environment] = "dev"
default[:zym_app][:debug]       = true

default[:zym_app][:dir]         = "/var/www/#{node[:zym_app][:domain]}/current"
default[:zym_app][:release_dir] = "/var/www/#{node[:zym_app][:domain]}"
default[:zym_app][:repository]  = "git@github.com:geoffreytran/symfony-zym.git"
default[:zym_app][:revision]    = "master"
default[:zym_app][:deploy_key]  = ""
