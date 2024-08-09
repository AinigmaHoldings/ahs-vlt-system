#!/bin/bash

sudo_create_file() {
    local FILE="$1"
    local SCRIPT_CONTENT="$2"

    # Create the directory if it doesn't exist
    sudo mkdir -p "$(dirname "$FILE")"

    # Write the content to the file using sudo tee
    echo "$SCRIPT_CONTENT" | sudo tee "$FILE" > /dev/null

    # Make the script executable
    sudo chmod +x "$FILE"

    echo "Script created successfully at: $FILE"
}
