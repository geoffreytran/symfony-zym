name "zym_queue"
description "Configures the node as a zym queue server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[queue]",

  "role[zym]",
  "recipe[zym::queue]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :redisio => {
    :servers => [
      { :port => '6379' }
    ]
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()