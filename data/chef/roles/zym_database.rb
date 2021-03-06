name "zym_database"
description "Configures the node as a zym database server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[database]",
  
  "role[zym]",
  "recipe[zym::database]"
)

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()