config_file_autoupgrade="/etc/apt/apt.conf.d/20auto-upgrades"
template_file_autoupgrade="src/templates/20auto-upgrades"

sudo cp $template_file_custom $config_file

sudo systemctl disable --now unattended-upgrades 
sudo apt remove unattended-upgrades
sudo systemctl stop apt-daily-upgrade.service 

#disabling screensaver
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
sudo apt remove gnome-screensaver