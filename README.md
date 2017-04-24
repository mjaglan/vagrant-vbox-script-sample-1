Example script to run ubuntu 14.04 in headless mode

##### How to run
```
vagrant up

vagrant ssh
```

##### vagrant ssh-config
```
  Host default
  HostName 127.0.0.1
  User vagrant
  Port 20022
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /path/to/github.com/repository/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardAgent yes
```
