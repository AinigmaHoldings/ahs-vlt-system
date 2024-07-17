###############################
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker ${USER}
newgrp docker
sudo systemctl status docker
################################
cd
mkdir vlt
cd vlt/
git clone https://github.com/AinigmaHoldings/ahs-vlt-system.git
cd ahs-vlt-system/
docker build -t ahsvlt .
docker images
################################################
nano /home/ahsvlt/vlt/vltStart.sh
##################################################

#!/bin/sh
/usr/bin/docker run -e DISPLAY=$DISPLAY -e LOBBY_URL=https://main.d1z9tjq0zx0et3.amplifyapp.com/ -v /tmp/.X11-unix:/tmp/.X11-unix --rm ahsvlt

################################################
nano /home/ahsvlt/vlt/printenv.sh
##################################################

#!/bin/bash
/usr/bin/printenv > /home/ahsvlt/environment

###########################################
chmod +x printenv.sh
###########################################
sudo nano /etc/systemd/system/vlt.service
############################################
[Unit]
Description=test service
After=graphical.target

[Service]
WorkingDirectory=/home/ahsvlt/vlt
User=ahsvlt
EnvironmentFile=/home/ahsvlt/environment
Restart=always
ExecStart=/bin/sh /home/ahsvlt/vlt/vltStart.sh
[Install]
WantedBy=default.target
##################################################

##################################################
sudo systemctl daemon-reload
sudo systemctl enable vlt.service
######################################################
mdkir /home/ahsvlt/.config/autostart
######################################################
nano /home/ahsvlt/.config/autostart/xhostdocker.desktop
[Desktop Entry]
Type=Application
Exec=xhost +local:docker
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=xhost new
Name=Xhost Docker enabler
Comment[en_US]=Giving permissions to docker for display
Comment=Giving permissions to docker for display

######################################################
nano /home/ahsvlt/.config/autostart/printenvlocal.desktop
[Desktop Entry]
Type=Application
Exec=/home/ahsvlt/vlt/printenv.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=PrintEnv Task for VLT Service
Name=PrintEnv Task for VLT Service
Comment[en_US]=Printing Env Variables for VLT service
Comment=Printing Env Variables for VLT service

sudo reboot
#Note: check if it is necessary to put chmod permissions for printenv.sh :chmod +x printenv.sh


 
 ubuntu@ip-10-0-0-221:~$ cat creatconfig.sh
#!/bin/bash

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
SCRIPT_CONTENT1="#!/bin/sh
/usr/bin/docker run -e DISPLAY=\$DISPLAY -e LOBBY_URL=https://main.d1z9tjq0zx0et3.amplifyapp.com/ -v /tmp/.X11-unix:/tmp/.X11-unix --rm ahsvlt
"

FILE2="/home/${USER}/vlt/printenv.sh"
SCRIPT_CONTENT2="#!/bin/sh
/usr/bin/printenv > /home/${USER}/environment
"

# Create first script file
create_script_file "$FILE1" "$SCRIPT_CONTENT1"

# Print separator for clarity
echo "--------------------------------"

# Create second script file
create_script_file "$FILE2" "$SCRIPT_CONTENT2"

echo "All scripts created successfully."




ubuntu@ip-10-0-0-221:~$ cat installdocker.sh
#!/bin/bash

# Update and install required packages
echo "Updating packages..."
sudo apt update -y
echo "Installing required packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key and set up the stable repository
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Setting up Docker's stable repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index and install Docker CE
echo "Updating package index..."
sudo apt update -y
echo "Checking Docker CE policy..."
apt-cache policy docker-ce
echo "Installing Docker CE..."
sudo apt install -y docker-ce

# Start and enable the Docker service
echo "Starting Docker service..."
sudo systemctl start docker.service
echo "Enabling Docker service..."
sudo systemctl enable docker.service

# Add the current user to the 'docker' group to manage Docker as a non-root user
echo "Adding user to docker group..."
sudo usermod -aG docker ${USER}
newgrp docker

# Create and navigate to the 'vlt' directory in the home directory
echo "Creating and navigating to 'vlt' directory..."
mkdir -p ~/vlt && cd ~/vlt

# Clone the 'ahs-vlt-system' repository from GitHub
echo "Cloning the repository..."
git clone https://github.com/AinigmaHoldings/ahs-vlt-system.git

# Navigate into the cloned repository directory
echo "Navigating into the repository directory..."
cd ahs-vlt-system

# Build the Docker image with the tag 'ahsvlt'
echo "Building the Docker image..."
docker build -t ahsvlt .

# List all Docker images
echo "Listing Docker images..."
docker images

echo "Script execution completed."




ubuntu@ip-10-0-0-221:~$ cat installvlt.sh
#!/bin/bash
# Create and navigate to the 'vlt' directory in the home directory
echo "Creating and navigating to 'vlt' directory..."
mkdir -p ~/vlt && cd ~/vlt

# Clone the 'ahs-vlt-system' repository from GitHub
echo "Cloning the repository..."
git clone https://github.com/AinigmaHoldings/ahs-vlt-system.git

# Navigate into the cloned repository directory
echo "Navigating into the repository directory..."
cd ahs-vlt-system

# Build the Docker image with the tag 'ahsvlt'
echo "Building the Docker image..."
docker build -t ahsvlt .

# List all Docker images
echo "Listing Docker images..."
docker images

echo "Script execution completed."