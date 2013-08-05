name "web"
description "Configures the node as a webserver."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[default]",

  "recipe[java]",
  "recipe[php]",
  "recipe[sqlite]",
  "recipe[nodejs]",
  "recipe[nodejs::npm]",
  "recipe[lesscss]",

  "recipe[apache2]",
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_alias]",
  "recipe[apache2::mod_auth_basic]",
  "recipe[apache2::mod_auth_digest]",
  "recipe[apache2::mod_deflate]",
  "recipe[apache2::mod_env]",
  "recipe[apache2::mod_expires]",
  "recipe[apache2::mod_headers]",
  "recipe[apache2::mod_rewrite]",
  "recipe[apache2::mod_setenvif]",
#  "recipe[apache2::mod_xsendfile]",
  "recipe[apache2::mod_ssl]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :apache => {
    :default_site_enabled => false,
    :serversignature      => "Off",
    :traceenable          => "Off"
  },

#  :php => {
#    :ext_conf_dir => "/etc/php5/mods-available" # php54
#  },

  :nodejs => {
    :install_method => "source",
    :dir            => "/usr",
    :npm            => "1.2.30"
  },
})

# Attributes applied no matter what the node has set already.
#override_attributes(
#  :apache => {
#    # Removed authz_default because it doesn't exist in Apache 2.4
#    :default_modules => %w{
#      status alias auth_basic authn_file authz_groupfile authz_host authz_user autoindex
#      dir env mime negotiation setenvif
#    }
#  }
#)