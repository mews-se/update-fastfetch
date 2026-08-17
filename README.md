# update-fastfetch

[![ShellCheck](https://github.com/mews-se/update-fastfetch/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/mews-se/update-fastfetch/actions/workflows/shellcheck.yml)
![Shell: Bash](https://img.shields.io/badge/shell-bash-4EAA25.svg?logo=gnubash&logoColor=white)
![Platform: Debian based](https://img.shields.io/badge/platform-Debian%20based-A81D33.svg?logo=debian&logoColor=white)
![Arch](https://img.shields.io/badge/arch-amd64%20%7C%20armv7l%20%7C%20arm64-informational)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Keep fastfetch up to date on Debian. Fetches the latest release from GitHub
and installs it, skips the download when you are already current. Works for
manual runs as well as provisioning and cron.

## Features

- Installs or upgrades fastfetch to the latest GitHub release
- Skips the download entirely when the installed version is up to date
- Detects the architecture (amd64, armv7l, arm64), including Pi Zero/1
  that report armhf but only run armv6 - upstream currently ships no
  armv6l build, so those machines get a clear error
- Runs as a normal user (sudo only when installing) or as root
- Only needs curl, apt-get, dpkg and mktemp

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
