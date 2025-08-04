# update‑fastfetch

**`update‑fastfetch`** is a lightweight shell script to automatically install, upgrade, or keep your Fastfetch binary up-to-date on supported Linux environments. Ideal for local machines or automated provisioning (e.g. servers or VMs).

---

## Features

- Automatically fetches the latest **Fastfetch** GitHub release.
- Installs or updates the binary to `/usr/local/bin/fastfetch`.
- Supports configuration backup and optional presets.
- Optionally integrates with cron, systemd timers, or provisioning tools.
- Logs actions and handles permissions gracefully.

---

## Supported Platforms

- Debian-based (Ubuntu, Debian ≥ 11 / 12)
- Arch Linux / AUR
- Fedora, openSUSE, Alpine, and others with Fastfetch support  
  *(note: only newer distros are supported via official prebuilt binaries; others may require source build)*

---

## Installation & Usage

### 1. Clone the repo, then chmod +x for whichever platform you use

```bash
git clone https://github.com/mews-se/update-fastfetch.git
cd update-fastfetch
chmod +x <whichever>.sh
./<whichever>.sh
