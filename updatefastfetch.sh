#!/usr/bin/env bash

set -euo pipefail

GITHUB_API_URL="https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest"

log() {
    printf '[%s] %s\n' "$(date '+%F %T')" "$*"
}

require_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: required command not found: $1" >&2
        exit 1
    fi
}

detect_architecture() {
    local dpkg_arch=""
    local uname_arch=""

    if command -v dpkg >/dev/null 2>&1; then
        dpkg_arch="$(dpkg --print-architecture 2>/dev/null || true)"
    fi
    uname_arch="$(uname -m 2>/dev/null || true)"

    case "$dpkg_arch" in
        amd64)
            echo "linux-amd64.deb"
            return 0
            ;;
        arm64)
            echo "linux-aarch64.deb"
            return 0
            ;;
        armhf)
            echo "linux-arm7l.deb"
            return 0
            ;;
    esac

    case "$uname_arch" in
        x86_64)
            echo "linux-amd64.deb"
            return 0
            ;;
        aarch64|arm64)
            echo "linux-aarch64.deb"
            return 0
            ;;
        armv7l|armv7*|armhf|arm7l)
            echo "linux-arm7l.deb"
            return 0
            ;;
    esac

    echo "Unsupported architecture. dpkg='${dpkg_arch:-unknown}', uname='${uname_arch:-unknown}'" >&2
    exit 1
}

fetch_release_url() {
    local asset_name="$1"
    local release_json
    local url

    release_json="$(curl -fsSL "$GITHUB_API_URL")"
    url="$(printf '%s\n' "$release_json" | grep "browser_download_url.*${asset_name}" | cut -d '"' -f 4 | head -n1)"

    if [[ -z "$url" ]]; then
        echo "Error: could not find release asset for ${asset_name}" >&2
        exit 1
    fi

    printf '%s\n' "$url"
}

main() {
    local asset_name
    local download_url
    local temp_deb

    require_command curl
    require_command sudo
    require_command apt-get
    require_command grep
    require_command cut
    require_command mktemp

    asset_name="$(detect_architecture)"
    log "Detected Fastfetch asset: ${asset_name}"

    download_url="$(fetch_release_url "$asset_name")"
    log "Resolved release URL: ${download_url}"

    temp_deb="$(mktemp "/tmp/fastfetch_latest_XXXXXX_${asset_name}")"
    trap 'rm -f "$temp_deb"' EXIT

    log "Downloading package to ${temp_deb}"
    curl -fsSL "$download_url" -o "$temp_deb"

    log "Installing package via apt-get"
    sudo apt-get install -y "$temp_deb"

    log "Fastfetch install/update complete"
}

main "$@"
