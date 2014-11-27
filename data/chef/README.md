VAGRANT DIRECTORY README
========================

This directory contains the files required for Vagrant to create a VM
suitable for running this application.

See http://vagrantup.com/ for more information.

Running Vagrant
---------------

Install the vagrant-hostmaster plugin:

    # vagrant plugin install vagrant-hostmaster

Run vagrant up to start the VM.

    # vagrant up

Rebuilding/Installing Chef Cookbooks
------------------------------------

In order to install or update the global Chef cookbooks, you must first
install `Berkshelf` [http://berkshelf.com/].

It is available using:

    # sudo gem install berkshelf
    
We install Berkshelf into vagrant's Ruby install also to ensure vagrant-berkshelf has access to it.

    # vagrant plugin install berkshelf
    # vagrant plugin install vagrant-berkshelf
    
After these two plugins are installed, the cookbooks should automatically be downloaded.