#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[+] Fixing Display${NC}"
if cp .Xauthority ~/ 2>/dev/null; then
    echo -e "${GREEN}    Success: .Xauthority copied to home directory${NC}"
else
    echo -e "${RED}    Error: Failed to copy .Xauthority - $?${NC}"
    echo -e "${RED}    Check if .Xauthority exists in the current directory${NC}"
fi

echo -e "${GREEN}[+] Fixing banner in tmux${NC}"
if echo '' > /etc/htb/banner.sh 2>/dev/null; then
    echo -e "${GREEN}    Success: Banner cleared in /etc/htb/banner.sh${NC}"
else
    echo -e "${RED}    Error: Failed to write to /etc/htb/banner.sh - $?${NC}"
    echo -e "${RED}    Check permissions or if directory exists${NC}"
fi

echo -e "${GREEN}[+] Setting up tmux${NC}"
if wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/.tmux.conf -O ~/.tmux.conf 2>/dev/null; then
    echo -e "${GREEN}    Success: .tmux.conf downloaded and updated${NC}"
else
    echo -e "${RED}    Error: Failed to download .tmux.conf - $?${NC}"
    echo -e "${RED}    Check internet connection or URL${NC}"
fi

echo -e "${GREEN}[+] Fixing IP in panel${NC}"
if wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/vpnpanel.sh -O /etc/htb/vpnpanel.sh 2>/dev/null; then
    if chmod +x /etc/htb/vpnpanel.sh 2>/dev/null; then
        echo -e "${GREEN}    Success: vpnpanel.sh downloaded and made executable${NC}"
    else
        echo -e "${RED}    Error: Failed to set executable permissions on vpnpanel.sh - $?${NC}"
        echo -e "${RED}    Check permissions or file existence${NC}"
    fi
else
    echo -e "${RED}    Error: Failed to download vpnpanel.sh - $?${NC}"
    echo -e "${RED}    Check internet connection or URL${NC}"
fi
