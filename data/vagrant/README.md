VAGRANT DIRECTORY README
========================

This directory contains the files required for Vagrant to create a VM
suitable for running this application.

See http://vagrantup.com/ for more information.

Running Vagrant
---------------

Install the vagrant-hostmaster plugin:

    # vagrant gem install vagrant-hostmaster

Run vagrant up to start the VM.

    # vagrant up

Rebuilding/Installing Chef Cookbooks
------------------------------------

In order to install or update the global Chef cookbooks, you must first
install `librarian-chef` [https://github.com/applicationsonline/librarian].

It is available using:

    # sudo gem install librarian

After librarian is installed you can call to updated the installed cookbooks:

    # librarian-chef install
