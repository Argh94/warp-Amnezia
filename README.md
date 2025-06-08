# Cloudflare WARP Config Generator

![Project Banner](https://via.placeholder.com/1200x300.png?text=Cloudflare+WARP+Config+Generator)

A Bash script to generate WireGuard configuration files for connecting to Cloudflare WARP VPN, optimized for use with the AmneziaWG client.

---

## 📋 Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Output](#output)
- [Troubleshooting](#troubleshooting)
- [Security Notes](#security-notes)
- [Using Replit for WARP Configs](#using-replit-for-warp-configs)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 📖 Introduction

This script automates the process of generating a WireGuard configuration file to connect to Cloudflare WARP, a free VPN service that enhances privacy and performance. Designed for ease of use in Termux, it installs dependencies automatically and provides a configuration file compatible with AmneziaWG and other WireGuard clients.

**Project Details:**
- **Author:** [Argh94](https://github.com/Argh94)
- **License:** MIT

---

## ✨ Features

- Generates valid WireGuard configurations for Cloudflare WARP.
- Automatically installs required dependencies (`jq`, `wireguard-tools`, `wget`) in Termux.
- User-friendly interface with a distinctive graphical header.
- Outputs configuration as text and provides a download link for the config file.
- Optimized for AmneziaWG but compatible with all WireGuard clients.
- Lightweight and secure, with no external dependencies beyond standard tools.

---

## 📦 Prerequisites

- **Termux:** Script is designed for Termux on Android. Other Linux environments may work but require manual installation of dependencies.
- **Internet Connection:** Required for installing dependencies and communicating with the Cloudflare WARP API.
- **Storage Permissions:** Ensure Termux has storage access for saving files (`termux-setup-storage` if needed).

---

## 🛠 Installation

1. **Open Termux** on your Android device.
2. **Update Termux repositories** if you encounter package issues:

    ```bash
    termux-change-repo
    ```

    Select a reliable mirror (e.g., Cloudflare) and confirm.

3. **Download and run the script:**

    ```bash
    curl -sL https://raw.githubusercontent.com/Argh94/warp-Amnezia/refs/heads/main/warp_config_Amnezia.sh -o warp_config_Amnezia.sh && chmod +x warp_config_Amnezia.sh && ./warp_config_Amnezia.sh
    ```

    This command downloads the script, makes it executable, and runs it.

---

## 🚀 Usage

Run the script as shown above.

The script will:
- Check and install dependencies (`jq`, `wireguard-tools`, `wget`).
- Generate a WireGuard configuration using the Cloudflare WARP API.
- Display the configuration and a download link.

### Use the Configuration

- **Download the Config File:** Open the provided link (e.g., `https://immalware.vercel.app/download?...`) in a browser to download `WARP.conf`.
- **Manual Copy:** Copy the configuration text (between `########## CONFIG START ##########` and `########## CONFIG END ##########`), save it as `WARP.conf`, and transfer it to your device.
- **Import:** Import the `WARP.conf` file into AmneziaWG or another WireGuard client.
- **Activate:** Enable the VPN in the app and test connectivity (e.g., visit [whatismyipaddress.com](https://whatismyipaddress.com) to verify your IP).

---

## 🖨 Output

The script outputs:

A graphical header:
```
     ▄█     ▄█
    ▄█ ░█▀▀ █▄
▄█  █████████  ▄█
███ ███┴┬┬███ █████
╔═══════════════════════════════════════╗
║ ♚ Project: Cloudflare WARP Config Generator  ║
║ ♚ Author: Argh94                             ║
║ ♚ GitHub: https://github.com/Argh94          ║
╚═══════════════════════════════════════╝
```

A WireGuard configuration, e.g.:
```ini
[Interface]
PrivateKey = [your_private_key]
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
Address = 172.16.0.2, [your_ipv6]
DNS = 1.1.1.1, 2606:4700:4700::1111, 1.0.0.1, 2606:4700:4700::1001

[Peer]
PublicKey = [cloudflare_public_key]
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 188.114.97.66:3138
```

- A download link for the config file.
- A support message with a link to your GitHub for issues.

---

## 🧑‍🔧 Troubleshooting

**"Unable to locate package" Error:**
- Run `termux-change-repo` to select a different mirror.
- Update packages:  
  ```bash
  pkg update && pkg install jq wireguard-tools wget -y
  ```

**VPN Not Connecting:**
- Verify your internet connection and API availability.

**Configuration Incomplete:**
- Ensure `jq` is installed (`which jq` should return a path).
- Debug API response by adding `echo "$response" > response.json` after the API call and inspecting `response.json`.

**Other Issues:**
- Share the full output with the author via GitHub: [https://github.com/Argh94](https://github.com/Argh94)

---

## 🔐 Security Notes

- **Trusted Sources:** Only run scripts from trusted repositories (e.g., this GitHub repo).
- **Download Link:** The config download link (`immalware.vercel.app`) is hosted on Vercel. Verify its authenticity before use.
- **API Usage:** The script uses Cloudflare’s WARP API (`https://api.cloudflareclient.com/v0i1909051800`). Be aware that API changes may affect functionality.

---

## 🌐 Using Replit for WARP Configs

Some users generate Cloudflare WARP configurations using Replit, an online coding platform. Here’s an overview:

**What is Replit?**
- Replit is a cloud-based IDE allowing you to run scripts in a virtual Linux environment. Users often run WARP config scripts on Replit to avoid local setup.

**How It Works:**
1. [Create a Replit Account](https://replit.com).
2. **New Repl:** Create a new Bash or Python Repl.
3. **Paste Script:** Copy a WARP config script (e.g., this project’s script) into the Repl’s main file.
4. **Run:** Execute the script to generate the configuration. Replit provides a terminal-like output with the config and download link.
5. **Use Config:** Download or copy the generated `WARP.conf` and import it into AmneziaWG or WireGuard.

**Pros of Using Replit:**
- No local setup required.
- Cross-platform (works on any device with a browser).
- Quick for one-off config generation.

**Cons of Using Replit:**
- Requires a stable internet connection.
- Free accounts have resource limits (can slow down or fail for complex scripts).
- Privacy risk: Running scripts on a third-party platform may expose sensitive data (e.g., private keys).
- Cloudflare's WARP API may block requests from shared Replit IPs.

**Comparison with This Script:**

|         | Termux (This Script)                | Replit                   |
|---------|-------------------------------------|--------------------------|
| Setup   | Local, needs initial setup          | No local setup           |
| Privacy | High (runs on device)               | Lower (cloud-based)      |
| Ease    | Optimized for Android/Termux users  | Easy for all platforms   |
| Limits  | None (besides device resources)     | Free tier resource limits|
| API     | Unlikely to hit rate limits         | May hit rate limits      |

**Recommendation:**
- Use this script in Termux for a reliable, private, and optimized experience.
- If you lack an Android device or prefer a browser-based solution, Replit is a viable alternative with caveats:
  - Use a private Repl.
  - Verify the WARP API works in Replit’s environment.
  - Export the config securely to avoid data exposure.

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. **Fork** the repository.
2. **Create a new branch:**  
   ```bash
   git checkout -b feature/your-feature
   ```
3. **Make changes and commit:**  
   ```bash
   git commit -m 'Add your feature'
   ```
4. **Push to your branch:**  
   ```bash
   git push origin feature/your-feature
   ```
5. **Open a Pull Request.**

Please report issues or suggest features via GitHub Issues.

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 📬 Contact

For any issues or questions, please create an issue or send a message through GitHub: [https://github.com/Argh94](https://github.com/Argh94)

---
