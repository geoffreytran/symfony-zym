name "queue"
description "Configures the node as a queue server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[beanstalkd]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :beanstalkd => {
    :daemon_opts       => "",
    :start_during_boot => true
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()