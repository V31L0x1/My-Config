#!/bin/bash

echo '[+] Fixing Display'
cp .Xauthority ~/

echo '[+] Fixing banner in tmux'
echo '' > /etc/htb/banner.sh

echo '[+] setting up tmux'
wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/.tmux.conf -O ~/.tmux.conf 2>/dev/null

echo '[+] Fixing IP in panel'
wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/vpnpanel.sh -O /etc/htb/vpnpanel.sh 2>/dev/null
chmod +x /etc/htb/vpnpanel.sh
