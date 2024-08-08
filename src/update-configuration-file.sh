# Extract the serial number of the baseboard
SERIAL_NUMBER=$(sudo dmidecode -t baseboard | grep "Serial Number:" | awk -F: '{print $2}' | xargs)

# Check if a serial number was found
if [ -z "$SERIAL_NUMBER" ]; then
    echo "Serial number not found."
fi

# Update vltSystemId in the config file
sed -i "s|^vltSerialBoard=[^ ]*|vltSerialBoard=${SERIAL_NUMBER}|" "$CONFIGURATION_FILE"
echo "Configuration file - Serial Number updated"

sed -i "s|^vltName=[^ ]*|vltName=${vltName}|" "$CONFIGURATION_FILE"
echo "Configuration file - VLT Name updated"

sed -i "s|^vltCode=[^ ]*|vltCode=${vltCode}|" "$CONFIGURATION_FILE"
echo "Configuration file - VLT Code updated"

sed -i "s|^storeid=[^ ]*|storeid=${storeid}|" "$CONFIGURATION_FILE"
echo "Configuration file - Store Id updated"

sed -i "s|^cloudflaredtoken=[^ ]*|cloudflaredtoken=${cloudflaredtoken}|" "$CONFIGURATION_FILE"
echo "Configuration file - Cloudflared Token updated"

sed -i "s|^cloudflaredtunnelid=[^ ]*|cloudflaredtunnelid=${cloudflaredtunnelid}|" "$CONFIGURATION_FILE"
echo "Configuration file - Cloudflared Tunnel Id updated"
