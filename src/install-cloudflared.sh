echo "Gathering Cloudflared Token Input"
cloudflaredToken=$1
echo $cloudflaredToken
echo "Uninstall cloudflared, expect some errors..."
sudo systemctl disable cloudflared.service
sudo apt-get remove -y --purge cloudflared
sudo rm -rf /etc/cloudflared
sudo systemctl disable cloudflared-update.timer
sudo rm -rf /etc/systemd/system/cloudflared.service
sudo rm -rf /etc/systemd/system/cloudflared-update.timer
sudo rm -rf /etc/systemd/system/cloudflared-update.service
sudo rm -rf cloudflared.deb 
echo "Installing cloudflared, do not expect errors" 
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb
 
sudo cloudflared service install $cloudflaredToken
echo "HOLA AMIGOS"