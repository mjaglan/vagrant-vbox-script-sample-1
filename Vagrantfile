# -*- mode: ruby -*-
# vi: set ft=ruby :
# Reference: https://peteris.rocks/blog/vagrantfile-for-linux/
# Reference: http://ricostacruz.com/cheatsheets/vagrantfile.html
# Fix: http://www.gisremotesensing.com/2016/06/solution-vagrant-remote-connection.html

# Specify Vagrant version
Vagrant.require_version ">= 1.6.0"
BOX_NAME = "Vagrant-Ubuntu-14.04"

Vagrant.configure(2) do |config|

  # Ubuntu 14.04 LTS x64 official cloud image
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false
  config.vm.hostname = "vagrant-test-bed"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
  config.vm.post_up_message = "Welcome to #{BOX_NAME}"

  #config.vm.network "private_network", type: "dhcp" # dynamic ip
  config.vm.network "private_network", ip: "10.10.10.10" # static ip

  # networking: https://www.vagrantup.com/docs/networking/forwarded_ports.html
  config.vm.network "forwarded_port", guest: 22, host: 20022, protocol: "tcp", auto_correct: false, id: "ssh"
  config.vm.network "forwarded_port", guest: 80, host: 20080, protocol: "tcp", auto_correct: true

  # SSH Settings
  # ISSUE: https://github.com/puphpet/puphpet/issues/2357
  config.ssh.forward_agent = true # If true, then any SSH connections made will enable agent forwarding.
  config.ssh.keep_alive = true

  # SYNCED FOLDER OPEN ISSUE [as of 26 Apr 2017]: https://github.com/mitchellh/vagrant/issues/7695
  # SYNCED FOLDER OPEN ISSUE [as of 26 Apr 2017]: https://pagure.io/atomic-wg/issue/181
  # ACTION: It doesn't seem to work on Windows 10. Disable synced_folder for now.
  config.vm.synced_folder "vagrant", "/vagrant", disabled: true, create: true


  # Set vagrant machine name http://stackoverflow.com/a/17864388
  config.vm.define :"#{BOX_NAME}" do |t|
  end


  # https://www.vagrantup.com/docs/virtualbox/configuration.html
  config.vm.provider "virtualbox" do |vb|
  	vb.name = "#{BOX_NAME}"
  	vb.cpus = 1
  	vb.memory = "2048"
  	vb.gui = false # run in background, headless mode and do vagrant ssh
  	vb.customize ["modifyvm", :id, "--cpuexecutioncap", "70", "--clipboard", "bidirectional", "--monitorcount", "1"]
  	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # fixes slow DNS lookups
  end


  # A Vagrant plugin to keep your VirtualBox Guest Additions up to date
  # LINK: https://github.com/dotless-de/vagrant-vbguest
  # HELP-1: http://discoposse.com/2016/05/23/autoupdating-virtualbox-guest-additions-with-vagrant-vbguest/
  # HELP-2: https://dzone.com/articles/automatically-download-and
  # set auto_update to false, if you do NOT want to check the correct
  # additions version when booting this machine
  config.vbguest.auto_update = true


  # LOCAL PROVISIONING ###############################################################################################
  config.vm.provision "shell", path: "post-boot.sh"

end
