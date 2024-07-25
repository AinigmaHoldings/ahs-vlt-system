#!/bin/bash
# Create executable files for systemd.
# Function to create script file

CONFIG_FILE="config/config.cfg"

# Extract the serial number of the baseboard
SERIAL_NUMBER=$(sudo dmidecode -t baseboard | grep "Serial Number:" | awk -F: '{print $2}' | xargs)

# Check if a serial number was found
if [ -z "$SERIAL_NUMBER" ]; then
    echo "Serial number not found."
fi
# Update vltSystemId in the config file
sed -i "s|^vltSerialBoard=[^ ]*|vltSerialBoard=${SERIAL_NUMBER}|" "$CONFIG_FILE"
echo "Serial number written in config file"

create_script_file() {
    local FILE="$1"
    local SCRIPT_CONTENT="$2"

    # Create the directory if it doesn't exist
    mkdir -p "$(dirname "$FILE")"

    # Write the content to the file
    echo "$SCRIPT_CONTENT" > "$FILE"

    # Make the script executable
    chmod +x "$FILE"

    echo "Script created successfully at: $FILE"
}

create_script_file_sudo() {
    local FILE="$1"
    local SCRIPT_CONTENT="$2"

    # Create the directory if it doesn't exist
    sudo mkdir -p "$(dirname "$FILE")"

    # Write the content to the file using sudo tee
    echo "$SCRIPT_CONTENT" | sudo tee "$FILE" > /dev/null

    # Make the script executable
    sudo chmod +x "$FILE"

    echo "Script created successfully at: $FILE"
}


# Define the file paths and script contents
# Read urlVlt from config file
#####--------
urlVlt=$(grep '^urlVlt=' "$CONFIG_FILE" | cut -d'=' -f2-)
vltName=$(grep '^vltName=' "$CONFIG_FILE" | cut -d'=' -f2-)
cloudflaredtoken=$(grep '^cloudflaredtoken=' "$CONFIG_FILE" | cut -d'=' -f2-)
cloudflaredtunnelid=$(grep '^cloudflaredtunnelid=' "$CONFIG_FILE" | cut -d'=' -f2-)
#####--------
FILE1="/home/${USER}/vlt/vltStart.sh"
echo $FILE1
SCRIPT_CONTENT1="#!/bin/sh
/usr/bin/docker run -e DISPLAY=\$DISPLAY -e LOBBY_URL=${urlVlt} -v /tmp/.X11-unix:/tmp/.X11-unix --rm ahsvlt
"

FILE2="/home/${USER}/vlt/printenv.sh"
echo $FILE2
SCRIPT_CONTENT2="#!/bin/sh
/usr/bin/printenv > /home/${USER}/environment

"

FILE3="/home/${USER}/vlt/Dockerfile"
echo $FILE3
SCRIPT_CONTENT3="

# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Evitar interacción al instalar paquetes
ENV DEBIAN_FRONTEND=noninteractive
ENV LOBBY_URL=https://www.google.com

# Actualizar el sistema e instalar dependencias
RUN apt-get update && apt-get install -y \
    firefox \
    x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crear un usuario no root
RUN useradd -ms /bin/bash firefoxuser

# Cambiar a usuario no root
USER firefoxuser
WORKDIR /home/firefoxuser

# Comando para ejecutar Firefox
CMD firefox --kiosk \$LOBBY_URL

"
##########SYSTEM FILES#################
FILE4="/etc/systemd/system/vlt.service"
echo $FILE4
SCRIPT_CONTENT4="[Unit]
Description=Docker Compose Application Service for VLT
Requires=docker.service
After=docker.service graphical.target
[Service]
WorkingDirectory=/home/${USER}/vlt
User=${USER}
EnvironmentFile=/home/${USER}/environment
ExecStart=/usr/bin/docker-compose up -d
[Install]
WantedBy=default.target"

#mkdir /home/ahsvlt/.config/autostart


##########AUTOSTART FILES#################
FILE5="/home/${USER}/.config/autostart/xhostdocker.desktop" 
echo $FILE5
SCRIPT_CONTENT5="[Desktop Entry]
Type=Application
Exec=xhost +local:docker
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=xhost new
Name=Xhost Docker enabler
Comment[en_US]=Giving permissions to docker for display
Comment=Giving permissions to docker for display"

FILE6="/home/${USER}/.config/autostart/printenvlocal.desktop" 
echo $FILE6
SCRIPT_CONTENT6="[Desktop Entry]
Type=Application
Exec=/home/${USER}/vlt/printenv.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=PrintEnv Task for VLT Service
Name=PrintEnv Task for VLT Service
Comment[en_US]=Printing Env Variables for VLT service
Comment=Printing Env Variables for VLT service"

#####################Docker compose files####################################
FILE7="/home/${USER}/vlt/docker-compose.yml" 
echo $FILE7
SCRIPT_CONTENT7="version: '3.8'

services:
  node_exporter:
    image: quay.io/prometheus/node-exporter:latest
    container_name: node_exporter
    command:
      - '--path.rootfs=/host'
    network_mode: host
    pid: host
    restart: unless-stopped
    volumes:
      - '/:/host:ro,rslave'
    ports:
      - "9100:9100/tcp"

  ahsvlt:
    image: ahsvlt
    container_name: ahsvlt_container
    environment:
      - DISPLAY=\${DISPLAY}
      - LOBBY_URL=${urlVlt}
    volumes:
      - '/tmp/.X11-unix:/tmp/.X11-unix'
    command: []
    networks:
      - default
    restart: 'always'   # Adjust restart policy if necessary

  cloudflared:
    image: cloudflare/cloudflared:latest
    network_mode: host
    volumes:
      - './config.yml:/etc/cloudflared/config.yml'
    entrypoint: cloudflared tunnel --config /etc/cloudflared/config.yml run --token $cloudflaredtoken

"

FILE8="/home/${USER}/vlt/config.yml" 
echo $FILE8
SCRIPT_CONTENT8="tunnel: $cloudflaredtunnelid
ingress:
  - hostname: $vltName.ainigmaim.com
    service: http://localhost:9100
  - hostname: ssh-$vltName.ainigmaim.com
    service: ssh://localhost:22
  - service: http_status:404 "

#############################################################################

# Create first script file
create_script_file "$FILE7" "$SCRIPT_CONTENT7"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE8" "$SCRIPT_CONTENT8"

# Print separator for clarity
echo "--------------------------------"

# Create first script file
create_script_file "$FILE1" "$SCRIPT_CONTENT1"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE2" "$SCRIPT_CONTENT2"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE3" "$SCRIPT_CONTENT3"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file_sudo "$FILE4" "$SCRIPT_CONTENT4"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE5" "$SCRIPT_CONTENT5"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE6" "$SCRIPT_CONTENT6"

echo "All scripts created successfully."

# Print separator for clarity
echo "--------------------------------"
echo "Enabling Services in systemd"
sudo systemctl daemon-reload
sudo systemctl enable vlt.service
######################################################
#mkdir /home/ahsvlt/.config/autostart

#echo "Installing VLT system and Node Exporter with docker compose...."
#cd compose/
#docker-compose up -d 
#echo "Installation succesfuly executed"