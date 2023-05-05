#!/bin/bash

# Disable NetworkManager
systemctl stop NetworkManager
systemctl disable NetworkManager

# Set static IP address for eth0
cat > /etc/network/interfaces.d/eth0.cfg <<EOF
auto eth0
iface eth0 inet dhcp
EOF

# Set up DHCP for eth1
cat > /etc/network/interfaces.d/eth1.cfg <<EOF
auto eth1
iface eth1 inet dhcp
EOF

# Set up DHCP server configuration for eth1
cat > /etc/dhcp/dhcpd.conf <<EOF
subnet 192.168.32.0 netmask 255.255.255.0 {
  range 192.168.32.100 192.168.32.200;
  option routers 192.168.32.1;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

# Enable IP forwarding and NAT
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

# Start DHCP server
systemctl enable isc-dhcp-server
systemctl start isc-dhcp-server
