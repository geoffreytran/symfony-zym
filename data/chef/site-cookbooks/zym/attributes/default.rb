include_attribute "apache2"
  
default[:zym][:user]              = node[:apache][:user]
default[:zym][:group]             = node[:apache][:group]

default[:zym][:db][:name]     = "zym"
default[:zym][:db][:user]     = node[:zym][:db][:name]
default[:zym][:db][:password] = "s23nSoq19hm26"

default[:zym][:queue][:port]     = "6379"
default[:zym][:queue][:database] = "0"

default[:zym][:mail][:transport]  = "mail"
default[:zym][:mail][:encryption] = ""
default[:zym][:mail][:auth_mode]  = "login"
default[:zym][:mail][:host]       = "127.0.0.1"
default[:zym][:mail][:port]       = "25"
default[:zym][:mail][:username]   = ""
default[:zym][:mail][:password]   = ""

default[:zym][:domain]         = node[:fqdn]
default[:zym][:domain_aliases] = []

default[:zym][:environment] = "prod"
default[:zym][:debug]       = false

default[:zym][:http_cache]  = true

default[:zym][:dir]         = "/var/www/#{node[:zym][:domain]}/current"
default[:zym][:release_dir] = "/var/www/#{node[:zym][:domain]}"

default[:zym][:repository]   = "git@github.com:geoffreytran/symfony-zym.git"
default[:zym][:revision]     = "master"
default[:zym][:deploy_key]   = ""
default[:zym][:force_deploy] = true

default[:zym][:parameters][:app][:name]           = "Untitled Symfony App"
default[:zym][:parameters][:app][:normalizedName] = "symfony-zym"