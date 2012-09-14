name "default"
description "Configures the defaults for each server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[apt]",
  "recipe[yum]",
  "recipe[screen]",
  "recipe[htop]",
  "recipe[rsync]",
  "recipe[git]",
  "recipe[subversion]",
  "recipe[chef-client]",
  "recipe[sudo]",
  "recipe[users::sysadmins]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  "authorization" => {
    "sudo" => {
      "groups" => ["sysadmin", "sudo"],
    }
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()