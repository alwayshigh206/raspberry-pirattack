#!/bin/bash

sudo chmod +x nat+routing.sh eth0-eth1-routing.sh dhcp-setup.sh
sudo ./nat+routing.sh
sudo ./eth0-eth1-routing.sh
sudo ./dhcp-setup.sh