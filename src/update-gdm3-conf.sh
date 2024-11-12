echo "Updating gdm3 - Wayland configurations and enable auto login"
config_file="/etc/gdm3/custom.conf"
template_file_custom="src/templates/custom.conf"

#sudo sed -i "s/^AutomaticLogin=ahsvlt/AutomaticLogin=${USER}/" "$template_file_custom"

sudo cp $template_file_custom $config_file

# Remove all lines that contain 'WaylandEnable'
#sudo sed -i '/WaylandEnable/d' "$config_file"

# Add 'WaylandEnable=false' at the end of file
#echo "WaylandEnable=false" | sudo tee -a "$config_file"
#sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' "$config_file"

