#!/bin/bash
# This script take eth0 from DHCP and make eth1
# subnet 192.168.32.1/24
# If you need change subnet - just change it below ;)
# Setting IP addresses for eth0 and eth1
sudo dhclient eth0
sudo tee /etc/network/interfaces > /dev/null <<EOT
auto lo
iface lo inet loopback

auto eth1
iface eth1 inet static
address 192.168.32.1
netmask 255.255.255.0
EOT

# Enabling routing
sudo sysctl -w net.ipv4.ip_forward=1

# Configuring NAT
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
sudo apt-get install -y iptables-persistent
sudo systemctl enable netfilter-persistent
sudo netfilter-persistent save

# Saving iptables settings
if [ -f /etc/iptables.ipv4.nat ]; then
  sudo rm /etc/iptables.ipv4.nat
fi
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

# Setting up autoloading of saved iptables settings
sudo touch /etc/rc.local
sudo sed -i '/exit 0/d' /etc/rc.local
sudo tee -a /etc/rc.local > /dev/null <<EOT
iptables-restore < /etc/iptables.ipv4.nat
exit 0
EOT
sudo systemctl restart networking
