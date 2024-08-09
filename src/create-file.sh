#!/bin/bash

create_file() {
    local FILE="$1"
    local SCRIPT_CONTENT="$2"

    # Create the directory if it doesn't exist
    mkdir -p "$(dirname "$FILE")"

    # Write the content to the file
    echo "$SCRIPT_CONTENT" > "$FILE"

    # Make the script executable
    chmod +x "$FILE"

    echo "Script created successfully at: $FILE"
}
