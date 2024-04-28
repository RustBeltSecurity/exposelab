#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo "Run as Root" 1>&2
  exit 1
fi

echo "[+] Updating System"
apt-get update -y
apt-get upgrade

echo "[+] Installing Dependancies"
apt-get install -y git virtualbox virtualbox-guest-utils virtualbox-guest-x11 python3-pip wget curl
pip install --update pip
pip install pywinrm

echo "[+] Installing Vagrant"
cd /opt
wget https://releases.hashicorp.com/vagrant/2.3.7/vagrant_2.3.7-1_amd64.deb
dpkg -i vagrant_2.3.7-1_amd64.deb
rm vagrant_2.3.7-1_amd64.deb
vagrant plugin install winrm
vagrant plugin install winrm-elevated


echo "[+] Downloading Lab"
git clone https://github.com/RustBeltSecurity/exposelab
cd exposelab

echo "[+] Downloading .net 4.8"
wget --no-check-certificate -P ./CoolScripts -O dotnet.4.8.exe https://go.microsoft.com/fwlink/?linkid=2088631

echo "[+] Adding Virtual Box Networks"
mkdir /etc/vbox
touch /etc/vbox/networks.conf
echo "* 10.0.0.0/8 192.168.0.0/16 195.0.0.0/8 172.16.0.0/8" >> /etc/vbox/networks.conf
echo "* 2001::/64" >> /etc/vbox/networks.conf

echo "[+] Starting Vagrant"
echo "[!] If you run into errors:
    - vagrant up again
        - increase timeout in Vagrantfile 
            config.vm.boot_timeout = 1800
            config.winrm.timeout = 1800
    - vagrant reload
    - Check Internet Connection 
        - dhclient <INTERFACE>
        - ping 1.1.1.1
    - rm /opt/vagrant/embedded/bin/curl"

vagrant up