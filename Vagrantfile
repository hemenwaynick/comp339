# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "lb01" do |lb01|
    lb01.vm.box = "ubuntu/xenial64"

    # Set hostname
    lb01.vm.hostname = "lb01"

    # Set ip
    lb01.vm.network :private_network, ip: "10.11.12.50"
  end


  config.vm.define "web01" do |web01|
    web01.vm.box = "ubuntu/xenial64"

    # Set hostname
    web01.vm.hostname = "web01"

    # Set ip
    web01.vm.network :private_network, ip: "10.11.12.51"

    # Use Chef Solo to provision our virtual machine
    web01.vm.provision :chef_solo do |chef|
      do_chef(chef)
    end
  end


  config.vm.define "web02" do |web02|
    web02.vm.box = "ubuntu/xenial64"

    # Set hostname
    web02.vm.hostname = "web02"

    # Set ip
    web02.vm.network :private_network, ip: "10.11.12.52"

    # Use Chef Solo to provision our virtual machine
    web02.vm.provision :chef_solo do |chef|
      do_chef(chef)
    end  
  end


  def do_chef(chef)
      chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

      chef.add_recipe "apt"
      chef.add_recipe "build-essential"
      chef.add_recipe "system::install_packages"
      chef.add_recipe "ruby_build"
      chef.add_recipe "ruby_rbenv::user"
      chef.add_recipe "ruby_rbenv::user_install"
      chef.add_recipe "vim"
      chef.add_recipe "postgresql::server"
      chef.add_recipe "postgresql::client"

      chef.json = {
        rbenv: {
          user_installs: [{
            user: 'ubuntu',
            rubies: ["2.4.0"],
            global: "2.4.0",
            gems: {
            "2.4.0" => [{ name: "bundler" }]
          }
          }]
        },
        system: {
          packages: {
            install: ["redis-server", "nodejs", "libpq-dev"]
          }
        },
        postgresql: {
          :pg_hba => [{
            :comment => "# Add vagrant role",
            :type => 'local', :db => 'all', :user => 'ubuntu', :addr => nil, :method => 'trust'
          }],
          :users => [{
            "username": "ubuntu",
            "password": "",
            "superuser": true,
            "replication": false,
            "createdb": true,
            "createrole": false,
            "inherit": false,
            "login": true
          }]
        }
      }
  end
end
