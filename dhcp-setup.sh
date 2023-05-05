#!/bin/bash

# Installing a DHCP server
sudo apt-get update
sudo apt-get install dhcpd

# Configuring the DHCP server
sudo cat << EOF > /etc/dhcpd.conf
subnet 192.168.32.0 netmask 255.255.255.0 {
  range 192.168.32.10 192.168.32.100;
  option routers 192.168.32.1;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

# Configuring the eth1 interface
sudo cat << EOF >> /etc/network/interfaces
auto eth1
iface eth1 inet static
  address 192.168.32.1
  netmask 255.255.255.0
EOF

# Restarting network settings
sudo service networking restart

# Starting a DHCP server
sudo systemctl enable dhcpd
sudo systemctl start dhcpd
