xhost +local:docker
docker run -e DISPLAY=$DISPLAY \
    -e LOBBY_URL="https://youtube.com" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native \
    -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native \
    --group-add audio \
    --rm ainigmagroup/kioskbrowser:6.0