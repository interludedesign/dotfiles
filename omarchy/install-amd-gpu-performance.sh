#!/usr/bin/env bash
set -euo pipefail

sudo tee /etc/systemd/system/amd-gpu-performance.service >/dev/null <<'EOF'
[Unit]
Description=Force AMD GPU high performance level
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo high > /sys/class/drm/card1/device/power_dpm_force_performance_level'

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now amd-gpu-performance.service
