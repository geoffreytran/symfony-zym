name "zym_cache"
description "Configures the node as a zym cache server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[cache]",

  "role[zym]",
  "recipe[zym::cache]"
)

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()