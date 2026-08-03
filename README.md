# update-fastfetch

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![ShellCheck](https://github.com/mews-se/update-fastfetch/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/mews-se/update-fastfetch/actions/workflows/shellcheck.yml)
![Platform](https://img.shields.io/badge/platform-Debian%2FUbuntu%2FDietPi-lightgrey)
![Arch](https://img.shields.io/badge/arch-amd64%20|%20armv6l%20|%20armv7l%20|%20arm64-green)
![Shell](https://img.shields.io/badge/shell-bash-blue)

Keep fastfetch up to date on Debian. Fetches the latest release from GitHub
and installs it, skips the download when you are already current. Works for
manual runs as well as provisioning and cron.

## Features

- Installs or upgrades fastfetch to the latest GitHub release
- Skips the download entirely when the installed version is up to date
- Detects the architecture (amd64, armv6l, armv7l, arm64), including
  Pi Zero/1 that report armhf but only run armv6
- Runs as a normal user (sudo only when installing) or as root
- Only needs curl, apt-get and mktemp

Debian, Ubuntu, DietPi and Raspberry Pi OS are the tested targets. Other
distributions may work if they take .deb packages.

## Usage

```bash
git clone https://github.com/mews-se/update-fastfetch.git
cd update-fastfetch
chmod +x updatefastfetch.sh
./updatefastfetch.sh
```

No sudo needed on the command line, the script elevates by itself when it is
time to install. Packages are downloaded to /tmp and cleaned up afterwards.

## Example output

```text
[2026-07-31 20:38:35] Detected Fastfetch asset: fastfetch-linux-amd64.deb
[2026-07-31 20:38:36] Updating Fastfetch 2.65.0 -> 2.66.0
[2026-07-31 20:38:36] Downloading package to /tmp/fastfetch_latest_Ab12Cd_linux-amd64.deb
[2026-07-31 20:38:38] Installing package via apt-get
[2026-07-31 20:38:40] Fastfetch install/update complete
```

## License

MIT License. See [LICENSE](LICENSE).
