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

# Get current IP address and default gateway for eth0
IPADDR_ETH0=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
GW_ETH0=$(ip -4 route show default | awk '/dev eth0/ {print $3}')

# eth0-eth1 routing script:
# Get current IP address for eth1
IPADDR_ETH1=$(ip -4 addr show eth1 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
if [[ -n "$IPADDR_ETH1" ]]; then
    sudo ip route add $IPADDR_ETH1/24 dev eth1
else
    echo "Could not find valid IP address for eth1"
fi

# Check if eth1 is up, bring it up if necessary
ETH1_STATUS=$(cat /sys/class/net/eth1/operstate)
if [[ "$ETH1_STATUS" == "down" ]]; then
    sudo ip link set eth1 up
fi

# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Set default route through eth0
sudo ip route replace default via $GW_ETH0 dev eth0

# Set route for eth1 network
sudo ip route add $IPADDR_ETH1/24 dev eth1
#sudo systemctl restart networking