#!/bin/sh
TEMPLATE_DOCKER_COMPOSE_YML="version: '3.8'
 
services:
  node_exporter:
    image: quay.io/prometheus/node-exporter:latest
    container_name: node_exporter
    command:
      - '--path.rootfs=/host'
    network_mode: host
    pid: host
    restart: unless-stopped
    volumes:
      - '/:/host:ro,rslave'
    ports:
      - "9100:9100/tcp"
 
  ahsvlt:
    image: ainigmagroup/kioskbrowser:6.0
    container_name: ahsvlt_container
    privileged: true
    environment:
      - DISPLAY=\${DISPLAY}
      - LOBBY_URL=${urlVlt}/landing?vltName=${vltName}&vltCode=${vltCode}&storeId=${storeid}
      - PULSE_SERVER=unix:\${XDG_RUNTIME_DIR}/pulse/native
    volumes:
      - '/tmp/.X11-unix:/tmp/.X11-unix'
      - '\${XDG_RUNTIME_DIR}/pulse/native:\${XDG_RUNTIME_DIR}/pulse/native'
    devices:
      - /dev/snd:/dev/snd
    command: []
    networks:
      - default
    restart: 'always'   # Adjust restart policy if necessary
 
  cloudflared:
    image: cloudflare/cloudflared:latest
    network_mode: host
    volumes:
      - './config.yml:/etc/cloudflared/config.yml'
    entrypoint: cloudflared tunnel --config /etc/cloudflared/config.yml run --token $cloudflaredtoken
"