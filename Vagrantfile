# -*- mode: ruby -*-
# vi: set ft=ruby :
# Reference: https://peteris.rocks/blog/vagrantfile-for-linux/
# Reference: http://ricostacruz.com/cheatsheets/vagrantfile.html

# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Ubuntu 14.04 LTS x64 official cloud image
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false
  config.vm.hostname = "vagrant-test-bed"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
  config.vm.network :private_network, ip: "192.168.100.100"
  
  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider "virtualbox" do |vb|
  	vb.name = "Vagrant-Ubuntu-14.04"
  	vb.cpus = 1
  	vb.memory = "4096"
  	vb.gui = false # run in background, headless mode and do vagrant ssh
  	vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  	vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  	vb.customize ["modifyvm", :id, "--monitorcount", "1"]
  	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # fixes slow DNS lookups
  end
  
  # networking: https://www.vagrantup.com/docs/networking/forwarded_ports.html
  config.vm.network "forwarded_port", guest: 22, host: 20022, protocol: "tcp", auto_correct: false, id: "ssh"
  config.vm.network "forwarded_port", guest: 80, host: 20080, protocol: "tcp", auto_correct: true

  # Run distribution update
  config.vm.provision "shell", inline: "sudo apt-get update"
  config.vm.provision "shell", inline: "sudo apt-get dist-upgrade"
  config.vm.provision "shell", inline: "sudo apt-get -f install"
  config.vm.provision "shell", inline: "sudo adduser vagrant vboxsf"
  config.vm.provision "shell", inline: "sudo echo Welcome to vagrant-ubuntu-14.04"

  # use local ubuntu mirror
  config.vm.provision :shell, inline: "sed -i 's/archive.ubuntu.com/lv.archive.ubuntu.com/g' /etc/apt/sources.list"

  # add swap
  config.vm.provision :shell, inline: "fallocate -l 4G /swapfile && chmod 0600 /swapfile && mkswap /swapfile && swapon /swapfile && echo '/swapfile none swap sw 0 0' >> /etc/fstab"
  config.vm.provision :shell, inline: "echo vm.swappiness = 10 >> /etc/sysctl.conf && echo vm.vfs_cache_pressure = 50 >> /etc/sysctl.conf && sysctl -p"

  # shared folder
  config.vm.provision :shell, inline: "sudo apt-get install linux-headers-$(uname -r) build-essential dkms"
  config.vm.provision :shell, inline: "wget http://download.virtualbox.org/virtualbox/5.1.16/VBoxGuestAdditions_5.1.16.iso"
  config.vm.provision :shell, inline: "sudo mkdir /media/VBoxGuestAdditions"
  config.vm.provision :shell, inline: "sudo mount -o loop,ro VBoxGuestAdditions_5.1.16.iso /media/VBoxGuestAdditions"
  config.vm.provision :shell, inline: "sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run"
  config.vm.provision :shell, inline: "rm VBoxGuestAdditions_5.1.16.iso"
  config.vm.provision :shell, inline: "sudo umount /media/VBoxGuestAdditions"
  config.vm.provision :shell, inline: "sudo rmdir /media/VBoxGuestAdditions"
  config.vm.synced_folder "./../../../", "/home/vagrant/CloudComputingSharedSpace", create: false, disabled: false
  
  # ssh settings
  # ISSUE: https://github.com/puphpet/puphpet/issues/2357
  config.ssh.forward_agent = true # If true, then any SSH connections made will enable agent forwarding.
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"
  config.ssh.keep_alive = true
  
end
