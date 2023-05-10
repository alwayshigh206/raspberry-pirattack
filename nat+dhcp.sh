#!/bin/bash

echo "Script needs sudo permissions!"

sudo chmod +x ./source/nat+routing.sh
sudo chmod +x ./source/dhcp-setup.sh
sudo ./source/nat+routing.sh

read -p "Install DHCP server? (yes/no): " answer

if [[ $answer == "yes" ]]; then
    sudo ./source/dhcp-setup.sh
    echo "DHCP server installed."
elif [[ $answer == "no" ]]; then
    echo "DHCP server installation skipped."
else
    echo "Invalid input. DHCP server installation skipped."
fi