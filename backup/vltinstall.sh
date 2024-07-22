#!/bin/bash
# Create and navigate to the 'vlt' directory in the home directory
echo "Creating and navigating to 'vlt' directory..."
cd ~/vlt

# Build the Docker image with the tag 'ahsvlt'
echo "Building the Docker image..."
docker build -t ahsvlt .

# List all Docker images
echo "Listing Docker images..."
docker images

echo "Script execution completed."