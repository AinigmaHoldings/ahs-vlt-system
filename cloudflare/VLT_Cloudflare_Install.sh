#################
#Pre Req##
#Verify OpenSSH service is running:
sudo systemctl status ssh.service
#Install openssh
sudo apt install open-ssh.service
#################Cloudflare####################
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb
cloudflared login
#----------------------------
#Take note of output
#-----------------------------
cloudflared tunnel list
cloudflared tunnel create vlt-lab-office  ##Change vlt name
cloudflared tunnel route dns vlt-lab-office vlt-lab-office.ainigmaim.com
sudo mkdir /etc/cloudflared
sudo vi /etc/cloudflared/config.yml
###Use login output to fulfill tunnel info and credentials-file
tunnel: 4d3f39c8-9646-49be-b761-1971fcfdc86e
credentials-file: /home/developer/.cloudflared/4d3f39c8-9646-49be-b761-1971fcfdc86e.json
url: ssh://localhost:22
#######
systemctl status ssh.service
sudo cloudflared --config /etc/cloudflared/config.yml service install
#####################################################################
##O&M###
sudo cloudflared service uninstall

####For client############
vi ~/.ssh/config
####################################
Host vlt-lab-0.ainigmaim.com
ProxyCommand /usr/local/bin/cloudflared access ssh --hostname %h
#####################################