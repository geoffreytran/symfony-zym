name "zym_queue_worker"
description "Configures the node as a zym queue worker."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[web]",

  "role[zym]",
  "recipe[zym::queue_worker]"
)

if not Chef::Config[:solo]
  run_list.push("recipe[zym]")
end

# Attributes applied if the node doesn't have it set already.
#default_attributes()

# Attributes applied no matter what the node has set already.
#override_attributes()