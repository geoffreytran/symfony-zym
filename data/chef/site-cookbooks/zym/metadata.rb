maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures zym"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends					 "apache2"
depends          "application"
depends					 "database"
depends          "mysql"
depends          "php"
depends          "composer"
depends          "symfony2"