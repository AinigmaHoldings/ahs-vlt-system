#!/bin/bash

sed -i "s|^vltSerialBoard=[^ ]*|vltSerialBoard=${SERIAL_NUMBER}|" "$CONFIGURATION_FILE"
echo "Configuration file - Serial Number updated"

sed -i "s|^vltName=[^ ]*|vltName=${vltName}|" "$CONFIGURATION_FILE"
echo "Configuration file - VLT Name updated"

sed -i "s|^vltCode=[^ ]*|vltCode=${vltCode}|" "$CONFIGURATION_FILE"
echo "Configuration file - VLT Code updated"

sed -i "s|^storeid=[^ ]*|storeid=${storeid}|" "$CONFIGURATION_FILE"
echo "Configuration file - Store Id updated"

sed -i "s|^latitude=[^ ]*|latitude=${latitude}|" "$CONFIGURATION_FILE"
echo "Configuration file - Latitude updated"

sed -i "s|^longitude=[^ ]*|longitude=${longitude}|" "$CONFIGURATION_FILE"
echo "Configuration file - Longitude updated"

sed -i "s|^cloudflaredtoken=[^ ]*|cloudflaredtoken=${cloudflaredtoken}|" "$CONFIGURATION_FILE"
echo "Configuration file - Cloudflared Token updated"

sed -i "s|^cloudflaredtunnelid=[^ ]*|cloudflaredtunnelid=${cloudflaredtunnelid}|" "$CONFIGURATION_FILE"
echo "Configuration file - Cloudflared Tunnel Id updated"
