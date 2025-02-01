#!/bin/bash

# 检测系统架构
arch=$(uname -m)

# 提示用户选择版本
echo "请选择要安装的版本:"
echo "1. qbittorrent 4.3.9 libtorrent 1.2.15"
echo "2. qbittorrent 4.3.9 libtorrent 2.0.5"
read -p "请输入选项 (1 或 2): " version

if [[ $version == "1" ]]; then
    if [[ $arch == "x86_64" ]]; then
        url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v1.2.15/x86_64-qbittorrent-nox"
    elif [[ $arch == "aarch64" ]]; then
        url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v1.2.15/aarch64-qbittorrent-nox"
    else
        echo "Unsupported architecture: $arch"
        exit 1
    fi
elif [[ $version == "2" ]]; then
    if [[ $arch == "x86_64" ]]; then
        url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v2.0.5/x86_64-qbittorrent-nox"
    elif [[ $arch == "aarch64" ]]; then
        url="https://github.com/userdocs/qbittorrent-nox-static/releases/download/release-4.3.9_v2.0.5/aarch64-qbittorrent-nox"
    else
        echo "Unsupported architecture: $arch"
        exit 1
    fi
else
    echo "无效选项: $version"
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
chmod +x "$work_dir"/qbittorrent-nox
./qbittorrent-nox <<< "y" &
sleep 3
pkill qbittorrent
systemctl enable --now qbittorrent
systemctl status qbittorrent --no-pager

echo "qBittorrent 已成功安装和配置，请尽快登入后台修改默认密码 "
echo "请访问 http://公网IP:8080 登录。"
echo "默认用户名: admin"
echo "默认密码: adminadmin"
