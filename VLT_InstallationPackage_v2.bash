###############################
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
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
sudo systemctl enable cloudflaredserverssh.service
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


 
 