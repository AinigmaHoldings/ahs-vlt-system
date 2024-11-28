#!/bin/bash

# Define the directory path
EXT_DIR="$HOME/.local/share/gnome-shell/extensions/disable-gestures-2021@ahsvlt"

# Create the directory if it doesn't exist
mkdir -p "$EXT_DIR"

# Create metadata.json with the provided content
cat > "$EXT_DIR/metadata.json" <<EOL
{
  "name": "Disable Gestures 2021",
  "description": "Disable all GNOME built-in gestures. Useful for kiosks and touchscreen apps.",
  "uuid": "disable-gestures-2021@ahsvlt",
  "shell-version": [
    "45",
    "46",
    "47"
  ],
  "url": "https://ainigmagaming.com"
}
EOL

# Create extension.js with the provided content
cat > "$EXT_DIR/extension.js" <<EOL
/**
 * Disable Gestures 2021
 *
 * A GNOME extension that disables built-in gestures. Useful for kiosks and touchscreen apps.
 */
export default class Extension {
  focusWindowId = null
  inFullscreenChangedId = null

  enable() {
    global.stage.get_actions().forEach(action => { action.enabled = false })
    const disableUnmaximizeGesture = () => {
      global.stage.get_actions().forEach(action => {
        if (action === this) return
        action.enabled = false
      })
    }
    if (this.focusWindowId === null) {
      this.focusWindowId = global.display.connect('notify::focus-window', disableUnmaximizeGesture)
    }
    if (this.inFullscreenChangedId === null) {
      this.inFullscreenChangedId = global.display.connect('in-fullscreen-changed', disableUnmaximizeGesture)
    }
  }

  disable() {
    if (this.inFullscreenChangedId !== null) {
      global.display.disconnect(this.inFullscreenChangedId)
      this.inFullscreenChangedId = null
    }
    if (this.focusWindowId !== null) {
      global.display.disconnect(this.focusWindowId)
      this.focusWindowId = null
    }
    global.stage.get_actions().forEach(action => { action.enabled = true })
  }
}
EOL

# Print success message
echo "Files created successfully in $EXT_DIR"
echo "Restarting GNOME"
sudo systemctl restart gdm
gnome-extensions enable disable-gestures-2021@ahsvlt
#gnome-extensions list
echo "Extension enabled, gestures has been disabled, patch is applied"