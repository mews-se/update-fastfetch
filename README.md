# update-fastfetch

![License](https://img.shields.io/badge/license-Unlicense-blue.svg)
![Platform](https://img.shields.io/badge/platform-Debian%2FUbuntu%2FDietPi-lightgrey)
![Arch](https://img.shields.io/badge/arch-amd64%20|%20armv6l%20|%20armv7l%20|%20arm64-green)
![Shell](https://img.shields.io/badge/shell-bash-blue)

**`update-fastfetch`** is a lightweight shell script to automatically install or upgrade **Fastfetch** to the latest release on supported Linux systems.

It is designed to be simple, portable, and suitable for both manual use and automated provisioning (e.g. servers, VMs, or bootstrap scripts).

---

## Features

- Installs or upgrades **Fastfetch** to the latest GitHub release
- Skips the download entirely when the installed version is already up to date
- Detects system architecture automatically (amd64, armv6l, armv7l, arm64)
- Downloads and installs the correct `.deb` package
- Works when run as a normal user (uses `sudo` only when required) or as root (no `sudo` needed)
- Minimal dependencies (`curl`, `apt-get`, `mktemp`)
- Clear logging output with timestamps

---

## Supported Platforms

Currently optimized for:

- Debian-based systems (Debian, Ubuntu, DietPi, Raspberry Pi OS)

Architecture support:
- `amd64`
- `armv6l` (Raspberry Pi Zero / Pi 1)
- `armv7l` / `armhf`
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
> - Check the installed version against the latest release
> - Download and install/update Fastfetch only when needed

---

## Notes

- You **do not need to run the script with sudo**  
  It will elevate privileges automatically when installing. Running as root works too — `sudo` is then not required at all.

- If Fastfetch is already up-to-date, the script exits without downloading anything.

- The script downloads packages to `/tmp` and cleans up automatically.

---

## Example Output

```text
[2026-07-31 20:38:35] Detected Fastfetch asset: fastfetch-linux-amd64.deb
[2026-07-31 20:38:36] Updating Fastfetch 2.65.0 -> 2.66.0
[2026-07-31 20:38:36] Downloading package to /tmp/fastfetch_latest_Ab12Cd_linux-amd64.deb
[2026-07-31 20:38:38] Installing package via apt-get
[2026-07-31 20:38:40] Fastfetch install/update complete
```

---

## License

This project is released into the public domain under **The Unlicense**. See [LICENSE](LICENSE).
