# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # https://www.vagrantup.com/docs/vagrantfile/machine_settings.html
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "xenial64-anyenv"
  config.vm.synced_folder ".", "/vagrant", nfs: true
  
  # config.vm.network "forwarded_port", guest: 1313, host: 1313, id: "hugo"
  # config.vm.network "forwarded_port", guest: 4000, host: 4000, id: "github-pages"
  # config.vm.network "forwarded_port", guest: 8000, host: 8000, id: "create-react-app"
  # config.vm.network "forwarded_port", guest: 8080, host: 8080, id: "wp"
  # config.vm.network "forwarded_port", guest: 8888, host: 8888, id: "drush"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "xenial64-anyenv"
    vb.cpus = 2
    vb.memory = "2048"
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end
  
  # provisioning
  config.vm.provision "shell", path: "upgrade-vboxguestadditions.sh"
  config.vm.provision "shell", privileged: false, path: "vagrant-provision.sh"
  
  # https://www.vagrantup.com/docs/vagrantfile/vagrant_settings.html#config-vagrant-plugins
  # config.vagrant.plugins = "vagrant-fsnotify"
  # https://github.com/adrienkohlbecker/vagrant-fsnotify
  # config.trigger.after :up do |t|
  #   t.name = "vagrant-fsnotify"
  #   t.run = { inline: "vagrant fsnotify" }
  # end

  # https://www.vagrantup.com/docs/virtualbox/configuration.html#linked-clones
  # https://bizwind.github.io/2019-06-26/improving-synced-folder-performance-in-vagrant#nfs-network-file-system
end
