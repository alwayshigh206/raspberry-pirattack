#!/bin/bash

# Get current IP address and default gateway for eth0
IPADDR_ETH0=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
GW_ETH0=$(ip -4 route show default | awk '/dev eth0/ {print $3}')

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