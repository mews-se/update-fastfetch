#!/usr/bin/env bash

# Fetch the latest fastfetch release URL for linux-arm7l deb file
FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-arm7l.deb" | cut -d '"' -f 4)

# Download the latest fastfetch deb file
curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_arm7l.deb

# Install the downloaded deb file using apt-get
sudo apt-get install /tmp/fastfetch_latest_arm7l.deb
