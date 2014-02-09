name "web"
description "Configures the node as a webserver."

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[default]",

  "recipe[apache2]",
  "recipe[apache2::mod_php5]",
  "recipe[apache2::mod_access_compat]",
  "recipe[apache2::mod_alias]",
  "recipe[apache2::mod_auth_basic]",
  "recipe[apache2::mod_auth_digest]",
  "recipe[apache2::mod_deflate]",
  "recipe[apache2::mod_env]",
  "recipe[apache2::mod_expires]",
  "recipe[apache2::mod_headers]",
  "recipe[apache2::mod_rewrite]",
  "recipe[apache2::mod_setenvif]"
#  "recipe[apache2::mod_xsendfile]",
#  "recipe[apache2::mod_ssl]"
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  :apache => {
    :default_site_enabled => false,
    :serversignature      => "Off",
    :traceenable          => "Off"
  },

  :php => {
    :directives => {
        "date.timezone" => "UTC",

        "upload_max_filesize" => "256M",
        "post_max_size"       => "256M",

        "apc.shm_size"     => "256M",
        "apc.write_lock"   => 1,
        "apc.slam_defense" => 0,

        "opcache.memory_consumption"      => 256,
        "opcache.interned_strings_buffer" => 8,
        "opcache.max_accelerated_files"   => 4000,
        "opcache.revalidate_freq"         => 2, # Should be a higher value such as 60 when in production.
        "opcache.fast_shutdown"           => 1,
        "opcache.enable_cli"              => 1,

        "realpath_cache_size" => "4096k",

        "xdebug.cli_color"               => 1,
        "xdebug.coverage_enable"         => 0,
        "xdebug.profiler_enable_trigger" => 1
    },
    :ext_conf_dir => "/etc/php5/mods-available" # php54
  },

  :nodejs => {
    :install_method => "source",
    :dir            => "/usr",
    :npm            => "1.2.30"
  },
})

# Attributes applied no matter what the node has set already.
#override_attributes()