#!/bin/bash

# Extract the serial number of the baseboard
SERIAL_NUMBER=$(sudo dmidecode -t baseboard | grep "Serial Number:" | awk -F: '{print $2}' | xargs)

# Check if a serial number was found
if [ -z "$SERIAL_NUMBER" ]; then
    echo "Serial number not found. Assigning DEFAULT"
    SERIAL_NUMBER="DEFAULTSN"
fi