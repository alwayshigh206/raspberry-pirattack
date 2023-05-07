#!/bin/bash
echo "Script needs sudo permissions!"
sudo chmod +x ./source/nat+routing.sh
sudo chmod +x ./source/dhcp-setup.sh
sudo ./source/nat+routing.sh
sudo ./source/dhcp-setup.sh