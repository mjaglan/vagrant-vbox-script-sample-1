Example script to run ubuntu 14.04 in headless mode

##### How to run
```
vagrant up

vagrant ssh
```

##### vagrant plugins installed
```
vagrant-registration (1.3.1)
vagrant-service-manager (1.5.0)
vagrant-share (1.1.7, system)
vagrant-vbguest (0.13.0)
```

##### vagrant ssh-config
```
Host Vagrant-Ubuntu-14.04
  HostName 127.0.0.1
  User vagrant
  Port 20022
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile .vagrant/machines/Vagrant-Ubuntu-14.04/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardAgent yes

```

##### For all available commands
```
vagrant --help
```

