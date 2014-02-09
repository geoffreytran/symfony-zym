name "default"
description "Configures the defaults for each server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[apt]",
  "recipe[yum]",
  "recipe[screen]",
  "recipe[htop]",
  "recipe[nano]",
  "recipe[rsync]",
  "recipe[git]",
  "recipe[subversion]",
  "recipe[build-essential]",
  "recipe[users::sysadmins]",

  "recipe[java]",
  "recipe[php54]",
  "recipe[php]",
  "recipe[sqlite]",
  "recipe[nodejs]",
  "recipe[nodejs::npm]",
  "recipe[lesscss]"
)

if not Chef::Config[:solo]
  run_list.push("recipe[chef-client::delete_validation]")
  run_list.push("recipe[chef-client::config]")
  run_list.push("recipe[chef-client]")
  run_list.push("recipe[sudo]")
end

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :authorization => {
    :sudo => {
      :groups       => ["sysadmin", "sudo"],
      :passwordless => true
    }
  },
  
  :build_essential => {
    :compiletime => true
  },

  :chef_client => {
    :config => {
      :client_fork => true
    }
  },

  :supervisor => {
    :version => "3.0b2"
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()