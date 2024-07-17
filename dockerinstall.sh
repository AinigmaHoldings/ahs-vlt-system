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