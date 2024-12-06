#!/bin/bash

# Define the directory path
EXT_DIR="$HOME/.local/share/gnome-shell/extensions/disable-gestures-2021@ahsvlt"
PATCH_DIR="$HOME/vlt/.patch"

# Create the directory if it doesn't exist
mkdir -p "$EXT_DIR"
mkdir -p "$PATCH_DIR"
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

# Create cron file for patches

# Create metadata.json with the provided content
cat > "$PATCH_DIR/patch_01_apply_patch.sh" <<EOL
#!/bin/bash

# Archivo de registro
FLAG_FILE="\$HOME/vlt/.patch/patch-01-gnome-exec.flag"

# Verifica si ya se ejecutó
if [ -f "\$FLAG_FILE" ]; then
    echo "El script ya se ejecutó anteriormente. Saliendo..."
    exit 0
fi

# Tu código aquí
echo "Ejecutando el script por primera vez..."
gnome-extensions enable disable-gestures-2021@ahsvlt
# Crear el archivo de registro
touch "\$FLAG_FILE"
EOL

# Create crontab file

#!/bin/bash

# Definir la nueva tarea de cron
NEW_CRON="@reboot $HOME/vlt/.patch/patch_01_apply_patch.sh >> $HOME/vlt/.patch/patch_01_apply_patch.log"

# Guardar la crontab existente en un archivo temporal
crontab -l > mycron || echo "" > mycron

# Comprobar si la tarea ya existe para evitar duplicados
if ! grep -Fxq "$NEW_CRON" mycron; then
    # Agregar la nueva tarea al archivo
    echo "$NEW_CRON" >> mycron
    # Instalar la nueva crontab
    crontab mycron
    echo "cron File for PATCH created"
else
    echo "Task already on crontab"
fi

# Limpiar el archivo temporal
rm -f mycron

# Print success message
echo "PATCH Files created successfully in $EXT_DIR and in PATCH_DIR"
