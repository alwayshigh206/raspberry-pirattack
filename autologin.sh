echo "Script nedds sudo permissions"

sudo mkdir /etc/lightdm/lightdm.conf.d
sudo cp ./source/autologin.conf  /etc/lightdm/lightdm.conf.d/

echo "Done. After rebooting, you should be automatically logged in without a username and password prompt."