#!/bin/bash
set -ex

WORKSPACE=/root/x-ui
mkdir -p ${WORKSPACE}
cd ${WORKSPACE}


wget --no-check-certificate -qO "x-ui-linux-amd64.tar.gz"  "https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz"


rm x-ui/ /usr/local/x-ui/ /usr/bin/x-ui -rf
tar zxvf x-ui-linux-amd64.tar.gz
chmod +x x-ui/x-ui x-ui/bin/xray-linux-* x-ui/x-ui.sh
cp x-ui/x-ui.sh /usr/bin/x-ui
cp -f x-ui/x-ui.service /etc/systemd/system/
mv x-ui/ /usr/local/
systemctl daemon-reload
systemctl enable x-ui
systemctl restart x-ui
rm -rf /root/x-ui
