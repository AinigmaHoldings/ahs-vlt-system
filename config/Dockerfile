# Use an Ubuntu base image
FROM ubuntu:20.04
 
# Prevent interaction while installing packages
ENV DEBIAN_FRONTEND=noninteractive
ENV LOBBY_URL=https://www.google.com
 
# Update the system and install dependencies
RUN apt-get update && apt-get install -y \
    firefox \
    x11-apps \
    mesa-utils \
    pulseaudio \
    alsa-utils \
    libasound2 \
    libcanberra-gtk-module \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
 
# Create a non-root user
RUN useradd -ms /bin/bash firefoxuser
 
# Switch to non-root user
USER firefoxuser
WORKDIR /home/firefoxuser
 
# Configure Firefox for WebGL (optional)
# You can adjust these parameters in the user's profile if necessary
 
# Command to run Firefox
CMD firefox --kiosk $LOBBY_URL