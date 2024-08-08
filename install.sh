#!/bin/bash

# Import functions
source src/create-file.sh
source src/sudo-create-file.sh

# Create configuration file
CONFIG_FILE="src/templates/config.cfg"
create_file "/home/${USER}/vlt/config/config.cfg" "$CONFIG_FILE"

# Current config file
CONFIGURATION_FILE="/home/${USER}/vlt/config/config.cfg"

# Update confiuration_file serial number
source src/update-serial-number.sh

# Read parameters from configuration file
source src/read-configuration-file.sh

# Files installation
TEMPLATE_PRINTENV="src/templates/printenv.sh"
create_file "/home/${USER}/vlt/printenv.sh" "$TEMPLATE_PRINTENV"

TEMPLATE_VLT_SERVICE="src/templates/vlt.service"
sudo_create_file "/etc/systemd/system/vlt.service" "$TEMPLATE_VLT_SERVICE"

TEMPLATE_XHOSTDOCKER_DESKTOP="src/templates/xhostdocker.desktop"
create_file "/home/${USER}/.config/autostart/xhostdocker.desktop" "$TEMPLATE_XHOSTDOCKER_DESKTOP"

TEMPLATE_PRINTENVLOCAL_DESKTOP="src/templates/printenvlocal.desktop"
create_file "/home/${USER}/.config/autostart/printenvlocal.desktop" "$TEMPLATE_PRINTENVLOCAL_DESKTOP"

TEMPLATE_DOCKER_COMPOSE_YML="src/templates/docker-compose.yml"
create_file "/home/${USER}/vlt/docker-compose.yml" "$TEMPLATE_DOCKER_COMPOSE_YML"

TEMPLATE_CONFIG_YML="src/templates/config.yml"
create_file "/home/${USER}/vlt/config.yml" "$TEMPLATE_CONFIG_YML"

# Enable services
echo "Enabling Services in systemd"
sudo systemctl daemon-reload
sudo systemctl enable vlt.service

# Install docker
source src/install-docker.sh
