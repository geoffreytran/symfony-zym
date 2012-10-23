name "zym_web"
description "Configures the node as a zym webserver."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[web]",
  
  "role[zym]",
  "recipe[zym]",
  "recipe[zym::apache]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
})

# Attributes applied no matter what the node has set already.
#override_attributes()