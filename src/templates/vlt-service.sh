TEMPLATE_VLT_SERVICE="[Unit]
Description=Docker Compose Application Service for VLT
Requires=docker.service
After=docker.service graphical.target
[Service]
WorkingDirectory=/home/${USER}/vlt
User=${USER}
EnvironmentFile=/home/${USER}/environment
ExecStart=/usr/bin/docker-compose up -d
[Install]
WantedBy=default.target
"