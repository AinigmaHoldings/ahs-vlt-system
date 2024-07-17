#!/bin/bash
# Create executable files for systemd.
# Function to create script file
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

# Define the file paths and script contents
FILE1="/home/${USER}/vlt/vltStart.sh"
echo $FILE1
SCRIPT_CONTENT1="#!/bin/sh
/usr/bin/docker run -e DISPLAY=\$DISPLAY -e LOBBY_URL=https://main.d1z9tjq0zx0et3.amplifyapp.com/ -v /tmp/.X11-unix:/tmp/.X11-unix --rm ahsvlt
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
CMD firefox --kiosk $LOBBY_URL

"
##########SYSTEM FILES#################
FILE4="/etc/systemd/system/vlt.service"
echo $FILE4
SCRIPT_CONTENT4="[Unit]
Description=test service
After=graphical.target
[Service]
WorkingDirectory=/home/${USER}/vlt
User=${USER}
EnvironmentFile=/home/${USER}/environment
Restart=always
ExecStart=/bin/sh /home/${USER}/vlt/vltStart.sh
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
[Desktop Entry]
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
create_script_file "$FILE4" "$SCRIPT_CONTENT4"

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
