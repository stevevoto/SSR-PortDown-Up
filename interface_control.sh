#!/bin/bash
cat <<'EOF' >/etc/systemd/system/interface_control.service
[Unit]
Description=Interface control service

[Service]
Type=simple
ExecStart=/bin/bash -c 'while true; do var="set provisional-status ge-0-2 down"; date=$(date +\%m-\%d-\%Y-\%H-\%M); su - admin -c "$var" 2; sleep 1800; var2="set provisional-status ge-0-2 up"; date=$(date +\%m-\%d-\%Y-\%H-\%M); su - admin -c "$var2" 2; sleep 1800; done'

[Install]
WantedBy=multi-user.target
EOF

chmod +x /etc/systemd/system/interface_control.service

##reload systemd
sudo systemctl daemon-reload

##Enable and start the service:
sudo systemctl enable  interface_control.service
sudo systemctl start  interface_control.service
