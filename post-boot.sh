echo "************************* post-boot.sh running *************************"

# use local ubuntu mirror
sudo sed -i 's/archive.ubuntu.com/lv.archive.ubuntu.com/g' /etc/apt/sources.list

# Run distribution update
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get -f install

# add vagrant user to vboxsf group
sudo adduser vagrant vboxsf

# Check VBoxGuestAdditions version - 
echo VBoxGuestAdditions $(lsmod | grep -io vboxguest | xargs modinfo | grep -iw version)

# If above doesn't work for updating VBoxGuestAdditions then use -
# LINK: https://www.vagrantup.com/docs/virtualbox/boxes.html
#sudo apt-get install linux-headers-$(uname -r) build-essential dkms
#wget http://download.virtualbox.org/virtualbox/5.1.16/VBoxGuestAdditions_5.1.16.iso
#sudo mkdir /media/VBoxGuestAdditions
#sudo mount -o loop,ro VBoxGuestAdditions_5.1.16.iso /media/VBoxGuestAdditions
#sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
#rm VBoxGuestAdditions_5.1.16.iso
#sudo umount /media/VBoxGuestAdditions
#sudo rmdir /media/VBoxGuestAdditions

