#!/bin/bash

# Import functions
source src/create-file.sh
source src/sudo-create-file.sh

# Create configuration file
CONFIG_FILE=$(cat "src/templates/config.cfg")
create_file "/home/${USER}/vlt/config/config.cfg" "$CONFIG_FILE"

# Current config file
CONFIGURATION_FILE="/home/${USER}/vlt/config/config.cfg"

# Update confiuration_file serial number
source src/update-serial-number.sh

# Read parameters from configuration file
source src/read-configuration-file.sh

# Files installation
TEMPLATE_PRINTENV=$(cat "src/templates/printenv.sh")
create_file "/home/${USER}/vlt/printenv.sh" "$TEMPLATE_PRINTENV"

TEMPLATE_XHOSTDOCKER_DESKTOP=$(cat "src/templates/xhostdocker.desktop")
create_file "/home/${USER}/.config/autostart/xhostdocker.desktop" "$TEMPLATE_XHOSTDOCKER_DESKTOP"

source src/template/config-yml.sh
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

# Install docker
source src/install-docker.sh
