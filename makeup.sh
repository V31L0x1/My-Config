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

echo -e "${GREEN}[+] Downloading OVPN files${NC}"
# Check if /etc/offsec/ exists, create it if not
if [ ! -d "/etc/offsec/" ]; then
    if mkdir -p /etc/offsec/ 2>/dev/null; then
        echo -e "${GREEN}    Success: Created directory /etc/offsec/${NC}"
    else
        echo -e "${RED}    Error: Failed to create /etc/offsec/ - $?${NC}"
        echo -e "${RED}    Check permissions (may need sudo)${NC}"
        exit 1  # Exit if directory creation fails
    fi
else
    echo -e "${GREEN}    Directory /etc/offsec/ already exists${NC}"
fi

# Download offsec-mani.ovpn
if wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/OVPN%20Files/offsec-mani.ovpn -O /etc/offsec/offsec-mani.ovpn 2>/dev/null; then
    echo -e "${GREEN}    Success: Downloaded offsec-mani.ovpn${NC}"
else
    echo -e "${RED}    Error: Failed to download offsec-mani.ovpn - $?${NC}"
    echo -e "${RED}    Check internet connection or URL${NC}"
fi

# Download offsec-bipin.ovpn
if wget https://raw.githubusercontent.com/V31L0x1/My-Config/refs/heads/main/OVPN%20Files/offsec-bipin.ovpn -O /etc/offsec/offsec-bipin.ovpn 2>/dev/null; then
    echo -e "${GREEN}    Success: Downloaded offsec-bipin.ovpn${NC}"
else
    echo -e "${RED}    Error: Failed to download offsec-bipin.ovpn - $?${NC}"
    echo -e "${RED}    Check internet connection or URL${NC}"
fi

echo -e "${GREEN}[+] Adding aliases to ~/.bashrc${NC}"
# Define aliases
ALIAS_BIPIN="alias offsec-bipin='openvpn /etc/offsec/offsec-bipin.ovpn'"
ALIAS_MANI="alias offsec-mani='openvpn /etc/offsec/offsec-mani.ovpn'"

# Check and add offsec-bipin alias
if ! grep -Fxq "$ALIAS_BIPIN" ~/.bashrc; then
    if echo "$ALIAS_BIPIN" >> ~/.bashrc 2>/dev/null; then
        echo -e "${GREEN}    Success: Added alias offsec-bipin to ~/.bashrc${NC}"
    else
        echo -e "${RED}    Error: Failed to add offsec-bipin alias - $?${NC}"
        echo -e "${RED}    Check write permissions for ~/.bashrc${NC}"
    fi
else
    echo -e "${GREEN}    Alias offsec-bipin already exists in ~/.bashrc${NC}"
fi

# Check and add offsec-mani alias
if ! grep -Fxq "$ALIAS_MANI" ~/.bashrc; then
    if echo "$ALIAS_MANI" >> ~/.bashrc 2>/dev/null; then
        echo -e "${GREEN}    Success: Added alias offsec-mani to ~/.bashrc${NC}"
    else
        echo -e "${RED}    Error: Failed to add offsec-mani alias - $?${NC}"
        echo -e "${RED}    Check write permissions for ~/.bashrc${NC}"
    fi
else
    echo -e "${GREEN}    Alias offsec-mani already exists in ~/.bashrc${NC}"
fi

# Source ~/.bashrc to apply aliases immediately
if source ~/.bashrc 2>/dev/null; then
    echo -e "${GREEN}    Success: Sourced ~/.bashrc - aliases are now active${NC}"
else
    echo -e "${RED}    Error: Failed to source ~/.bashrc - $?${NC}"
    echo -e "${RED}    Check if ~/.bashrc exists and is readable${NC}"
fi

echo -e "${GREEN}[+] Downloading Tools${NC}"
if git clone https://github.com/V31L0x1/Red-Team-Tools.git 2>/dev/null; then
    echo -e "${GREEN}    Success: Cloned Red-Team-Tools repository${NC}"
else
    echo -e "${RED}    Error: Failed to clone Red-Team-Tools - $?${NC}"
    echo -e "${RED}    Check internet connection, GitHub access, or if git is installed${NC}"
fi
