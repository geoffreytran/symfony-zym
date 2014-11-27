name "database"
description "Configures the node as a database server."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[default]",
  
  "recipe[mysql::client]",
  "recipe[mysql::server]",
  "recipe[mysql_timezone]",

  "recipe[database::mysql]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :mysql => {
    :allow_remote_root      => false,
    :remove_anonymous_users => true,
    :remove_test_database   => true,
    :enable_utf8            => "true"
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()