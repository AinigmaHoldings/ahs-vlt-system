urlVlt=$(grep '^urlVlt=' "$CONFIGURATION_FILE" | cut -d'=' -f2-)
vltName=$(grep '^vltName=' "$CONFIGURATION_FILE" | cut -d'=' -f2-)
cloudflaredtoken=$(grep '^cloudflaredtoken=' "$CONFIGURATION_FILE" | cut -d'=' -f2-)
cloudflaredtunnelid=$(grep '^cloudflaredtunnelid=' "$CONFIGURATION_FILE" | cut -d'=' -f2-)