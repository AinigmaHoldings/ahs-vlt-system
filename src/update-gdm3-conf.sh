config_file="/etc/gdm3/custom.conf"

# Remove all lines that contain 'WaylandEnable'
#sudo sed -i '/WaylandEnable/d' "$config_file"

# Add 'WaylandEnable=false' at the end of file
#echo "WaylandEnable=false" | sudo tee -a "$config_file"
sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' "$config_file"
