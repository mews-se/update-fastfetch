# update-fastfetch

![License](https://img.shields.io/badge/license-Unlicense-blue.svg)
![Platform](https://img.shields.io/badge/platform-Debian%2FUbuntu%2FDietPi-lightgrey)
![Arch](https://img.shields.io/badge/arch-amd64%20|%20armhf%20|%20arm64-green)
![Shell](https://img.shields.io/badge/shell-bash-blue)

**`update-fastfetch`** is a lightweight shell script to automatically install or upgrade **Fastfetch** to the latest release on supported Linux systems.

It is designed to be simple, portable, and suitable for both manual use and automated provisioning (e.g. servers, VMs, or bootstrap scripts).

---

## Features

- Automatically fetches the latest **Fastfetch** release from GitHub
- Detects system architecture automatically (amd64, armhf, arm64)
- Downloads and installs the correct `.deb` package
- Works when run as a normal user (uses `sudo` only when required)
- Minimal dependencies (`curl`, `grep`)
- Clear logging output with timestamps

---

## Supported Platforms

Currently optimized for:

- Debian-based systems (Debian, Ubuntu, DietPi)

Architecture support:
- `amd64`
- `armhf` / `armv7l`
- `arm64` / `aarch64`

Other distributions may work if `.deb` packages are compatible.

---

## Installation & Usage

### 1. Clone the repository

```bash
git clone https://github.com/mews-se/update-fastfetch.git
cd update-fastfetch
```

### 2. Make the script executable

```bash
chmod +x updatefastfetch.sh
```

### 3. Run the script

```bash
./updatefastfetch.sh
```

> The script will automatically:
> - Detect your system architecture
> - Fetch the latest release
> - Download and install/update Fastfetch

---

## Notes

- You **do not need to run the script with sudo**  
  It will elevate privileges automatically when installing.

- If Fastfetch is already up-to-date, no changes will be made.

- The script downloads packages to `/tmp` and cleans up automatically.

---

## Example Output

```text
[2026-04-01 20:38:35] Detected Fastfetch asset: linux-amd64.deb
[2026-04-01 20:38:36] Resolved release URL: https://github.com/fastfetch-cli/fastfetch/releases/download/...
[2026-04-01 20:38:36] Downloading package...
[2026-04-01 20:38:38] Installing package via apt-get
[2026-04-01 20:38:40] Fastfetch install/update complete
```

---

## License

This project is released into the public domain under **The Unlicense**.

---

## Notes

- You **do not need to run the script with sudo**  
  It will elevate privileges automatically when installing.

- If Fastfetch is already up-to-date, no changes will be made.

- The script downloads packages to `/tmp` and cleans up automatically.

---

## Example Output

```text
[2026-04-01 20:38:35] Detected Fastfetch asset: linux-amd64.deb
[2026-04-01 20:38:36] Resolved release URL: https://github.com/fastfetch-cli/fastfetch/releases/download/...
[2026-04-01 20:38:36] Downloading package...
[2026-04-01 20:38:38] Installing package via apt-get
[2026-04-01 20:38:40] Fastfetch install/update complete
```

---

## License

MIT (or same as original project if applicable)
