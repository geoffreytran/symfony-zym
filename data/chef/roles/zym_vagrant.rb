name "zym_vagrant"
description "Configures the node as a vagrant webserver."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[web]",

  "role[zym]",
  "recipe[zym::apache]",
  "recipe[zym::php]",
  "recipe[zym::vagrant]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :zym => {
    :environment => 'dev',
    :debug       => true,
  },

  :php => {
    :conf_dir => "/etc/php5/apache2",
    :directives => {
      "xdebug.max_nesting_level" => 200
    }
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()