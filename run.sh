#!/bin/bash

sudo chmod +x ./source/nat+routing.sh ./source/eth0-eth1-routing.sh 
sudo chmod +x ./source/dhcp-setup.sh
sudo ./source/nat+routing.sh && sudo ./source/eth0-eth1-routing.sh
sudo ./source/dhcp-setup.sh