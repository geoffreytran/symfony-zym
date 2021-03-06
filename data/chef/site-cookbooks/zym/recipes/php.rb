#
# Cookbook Name:: zym_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install curl
package "php5-curl" do
  action :install
end

# install mysql
package "php5-mysql" do
  action :install
end

# install sqlite 
package "php5-sqlite" do
  action :install
end

# install sybase/mssql
package "php5-sybase" do
    action :install
end

# install odbc
package "php5-odbc" do
    action :install
end

# install gd
package "php5-gd" do
  action :install
end

# install imagick
package "php5-imagick" do
  action :install
end

# install intl
package "php5-intl" do
  action :install
end

# install mcrypt
package "php5-mcrypt" do
  action :install
end

# install memcached
package "php5-memcached" do
  action :install
end

# install the mongodb pecl
#php_pear "mongo" do
#  action :install
#end

# install apc pecl with directives
package "libpcre3-dev" do
  action :install
end

package "php-apc" do
  action :install
end

template "/etc/php5/apache2/conf.d/override.ini" do
  source "php-settings.ini"
  mode 0644
  owner "root"
  group "root"
  variables({
    :directives => node[:php][:directives]
  })

  if cookbook
    cookbook cookbook
  end

  not_if { node[:php].empty? && node[:php][:directives].empty? }
end

if node[:zym][:environment] == 'dev'
  # install xdebug
  package "php5-xdebug" do
    action :install
  end
end

npm_package "uglify-js"
npm_package "uglifycss"