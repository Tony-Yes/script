#!/bin/bash

# 检测系统架构
arch=$(uname -m)

if [[ $arch == "x86_64" ]]; then
    url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v1.2.15/x86_64-qbittorrent-nox"
elif [[ $arch == "aarch64" ]]; then
    url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v1.2.15/aarch64-qbittorrent-nox"
else
    echo "Unsupported architecture: $arch"
    exit 1
fi

# 设置工作目录
work_dir="/opt"
cd "$work_dir" || exit 1

# 下载文件并更改文件名
file_name="qbittorrent-nox"
wget -O "$file_name" "$url"

# 增加守护进程
cat << "EOF" > /etc/systemd/system/qbittorrent.service
[Unit]
Description=qBittorrent Daemon Service
After=network.target

[Service]
LimitNOFILE=512000
User=root
ExecStart=/opt/qbittorrent-nox

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
chmod +x qbittorrent-nox
./qbittorrent-nox <<< "y"
systemctl enable --now qbittorrent
systemctl status qbittorrent