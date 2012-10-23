name "zym"
description "Configures the node as a zym application server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list()

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :zym => {
    :repository => 'git@github.com:geoffreytran/symfony-zym.git',
    :domain      => 'zym.dev',
    :environment => 'prod',
    :debug       => false,
    :dir         => '/var/www/symfony-zym/current',
    :release_dir => '/var/www/symfony-zym',
    :deploy_key  => '',
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()