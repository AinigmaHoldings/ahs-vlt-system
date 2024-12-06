#!/bin/bash
# Guardar el input proporcionado como parámetro
VLTCODE=$1

# Verificar si se ha proporcionado un input
if [ -n "$VLTCODE" ]; then
    echo "El valor del input es: $VLTCODE"
else
    echo "Error: VLT Code missing"
    exit 1
fi
echo "Continua"

# Cambia hostname

 sudo hostnamectl set-hostname $VLTCODE

# Import functions
source src/create-file.sh
source src/sudo-create-file.sh

# source src/input-vlt-information.sh
source src/get-serial-number.sh
echo "Extracting VLT Information for VLT: $VLTCODE"
source src/get-vlt-information.sh $VLTCODE

# Install cloudflared
source src/install-cloudflared.sh $cloudflaredtoken
#exit 0

# Create configuration file
CONFIG_FILE=$(cat "src/templates/config.cfg")
create_file "/home/${USER}/vlt/config/config.cfg" "$CONFIG_FILE"

# Current config file
CONFIGURATION_FILE="/home/${USER}/vlt/config/config.cfg"

# Update confiuration file
source src/update-configuration-file.sh

# Read parameters from configuration file
source src/read-configuration-file.sh

# Files installation
TEMPLATE_PRINTENV=$(cat "src/templates/printenv.sh")
create_file "/home/${USER}/vlt/printenv.sh" "$TEMPLATE_PRINTENV"

TEMPLATE_XHOSTDOCKER_DESKTOP=$(cat "src/templates/xhostdocker.desktop")
create_file "/home/${USER}/.config/autostart/xhostdocker.desktop" "$TEMPLATE_XHOSTDOCKER_DESKTOP"

source src/templates/config-yml.sh
create_file "/home/${USER}/vlt/config.yml" "$TEMPLATE_CONFIG_YML"

source src/templates/vlt-service.sh
sudo_create_file "/etc/systemd/system/vlt.service" "$TEMPLATE_VLT_SERVICE"

source src/templates/printenvlocal-desktop.sh
create_file "/home/${USER}/.config/autostart/printenvlocal.desktop" "$TEMPLATE_PRINTENVLOCAL_DESKTOP"

source src/templates/docker-compose.sh
create_file "/home/${USER}/vlt/docker-compose.yml" "$TEMPLATE_DOCKER_COMPOSE_YML"

# Enable services
echo "Enabling Services in systemd"
sudo systemctl daemon-reload
sudo systemctl enable vlt.service

# Install utilities
sudo apt install -y sed curl openssh-server cockpit

# Update sudo nano /etc/gdm3/custom.conf WaylandEnable=false and enabling automatic login
source src/update-gdm3-conf.sh

# Disabling autoupdates and screensaver
source src/disable-autoupdates.sh

# Disable gnome-gestures
source src/disable-gnome-gestures.sh

# Deactivating automatic updates

# Changing hostname

# Disabling automatic login

# Install docker
source src/install-docker.sh
