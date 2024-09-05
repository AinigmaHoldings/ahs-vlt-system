config_file="/etc/gdm3/custom.conf"

# Remove all lines that contain 'WaylandEnable'
sed -i '/WaylandEnable/d' "$config_file"

# Add 'WaylandEnable=false' at the end of file
echo "WaylandEnable=false" >> "$config_file"
