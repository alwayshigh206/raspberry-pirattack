#!/bin/bash

#install hostapd
sudo apt-get update
sudo apt-get install -y hostapd
sudo ifconfig wlan1 up 192.168.1.1 netmask 255.255.255.0
sudo cp ./configs-wap/dnsmasq.conf /etc/dnsmasq.d/dnsmasq.conf
sudo cp ./configs-wap/hostapd.conf /etc/hostapd/hostapd.conf
sudo systemctl restart dnsmasq
sudo systemctl restart hostapd
