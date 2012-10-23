include_attribute "apache2"
  
default[:zym][:user]              = node[:apache][:user]
default[:zym][:group]             = node[:apache][:group]

default[:zym][:db][:name]     = "zym"
default[:zym][:db][:user]     = node[:zym][:db][:name]
default[:zym][:db][:password] = "s23nSoq19hm26"

default[:zym][:domain]         = node[:fqdn]
default[:zym][:domain_aliases] = []

default[:zym][:environment] = "prod"
default[:zym][:debug]       = false

default[:zym][:dir]         = "/var/www/#{node[:zym][:domain]}/current"
default[:zym][:release_dir] = "/var/www/#{node[:zym][:domain]}"

default[:zym][:repository]   = "git@github.com:geoffreytran/symfony-zym.git"
default[:zym][:revision]     = "master"
default[:zym][:deploy_key]   = ""
default[:zym][:force_deploy] = true

default[:zym][:parameters][:app][:normalizedName] = "symfony-zym"