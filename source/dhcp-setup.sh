#!/bin/bash

# Installing a DHCP server
sudo apt-get update
sudo apt-get install -y dnsmasq

sudo cp dnsmasq.conf /etc/dnsmasq.conf

sudo systemctl start dnsmasq

sudo systemctl enable dnsmasq
