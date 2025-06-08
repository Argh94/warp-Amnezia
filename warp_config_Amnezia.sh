#!/bin/bash

clear
echo "Checking and installing dependencies for Termux..."

if [ -d "/data/data/com.termux" ]; then
    echo "Detected Termux environment. Updating packages and installing dependencies..."
    pkg update -y && pkg upgrade -y
    pkg install jq wireguard-tools wget -y
    
    for cmd in jq wg wget; do
        if ! command -v $cmd >/dev/null 2>&1; then
            echo "Error: Failed to install $cmd. Please check your internet connection or Termux repositories."
            exit 1
        fi
    done
else
    echo "This script is designed for Termux. If you're not using Termux, manually install jq, wireguard-tools, and wget."
    echo "Attempting to install dependencies using apt (for non-Termux environments)..."
    apt update -y && apt install sudo -y
    sudo apt-get update -y --fix-missing && sudo apt-get install wireguard-tools jq wget -y --fix-missing
fi

mkdir -p ~/.cloudshell && touch ~/.cloudshell/no-apt-get-warning

echo "Generating WireGuard configuration..."

priv="${1:-$(wg genkey)}"
pub="${2:-$(echo "${priv}" | wg pubkey)}"
api="https://api.cloudflareclient.com/v0i1909051800"
ins() { curl -s -H 'user-agent:' -H 'content-type: application/json' -X "$1" "${api}/$2" "${@:3}"; }
sec() { ins "$1" "$2" -H "authorization: Bearer $3" "${@:4}"; }
response=$(ins POST "reg" -d "{\"install_id\":\"\",\"tos\":\"$(date -u +%FT%T.000Z)\",\"key\":\"${pub}\",\"fcm_token\":\"\",\"type\":\"ios\",\"locale\":\"en_US\"}")

clear
echo -e "DO NOT USE GOOGLE CLOUD SHELL FOR GENERATION! If you are currently in Google Cloud Shell, read the latest guide: https://t.me/immalware/1211\n"

echo -e "\e[32m             ▄▀▄     ▄▀▄"
echo -e "\e[32m            ▄█░░▀▀▀▀▀░░█▄"
echo -e "\e[32m        ▄▄  █░░░░░░░░░░░█  ▄▄"
echo -e "\e[32m       █▄▄█ █░░█░░┬░░█░░█ █▄▄█"
echo -e "\e[36m ╔═══════════════════════════════════════╗"
echo -e "\e[32m ║ ♚ Project: Cloudflare WARP Config AmneziaWG  ║"
echo -e "\e[32m ║ ♚ Author: Argh94                             ║"
echo -e "\e[32m ║ ♚ GitHub: https://GitHub.com/Argh94          ║"
echo -e "\e[36m ╚═══════════════════════════════════════╝"
echo -e "\e[0m"

id=$(echo "$response" | jq -r '.result.id')
token=$(echo "$response" | jq -r '.result.token')
response=$(sec PATCH "reg/${id}" "$token" -d '{"warp_enabled":true}')
peer_pub=$(echo "$response" | jq -r '.result.config.peers[0].public_key')
client_ipv4=$(echo "$response" | jq -r '.result.config.interface.addresses.v4')
client_ipv6=$(echo "$response" | jq -r '.result.config.interface.addresses.v6')

conf=$(cat <<-EOM
[Interface]
PrivateKey = ${priv}
S1 = 0
S2 = 0
Jc = 120
Jmin = 23
Jmax = 911
H1 = 1
H2 = 2
H3 = 3
H4 = 4
MTU = 1280
Address = ${client_ipv4}, ${client_ipv6}
DNS = 1.1.1.1, 2606:4700:4700::1111, 1.0.0.1, 2606:4700:4700::1001

[Peer]
PublicKey = ${peer_pub}
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 188.114.97.66:3138
EOM
)

echo -e "\n\n\n"
[ -t 1 ] && echo "########## CONFIG START ##########"
echo "${conf}"
[ -t 1 ] && echo "########## CONFIG END ##########"

echo -e "\n"
conf_base64=$(echo -n "${conf}" | base64 -w 0)
echo "Download the config as a file: https://immalware.vercel.app/download?filename=WARP.conf&content=${conf_base64}"
echo -e "\n"
echo "you experience any problems, please contact me via my GitHub account, as indicated above."
