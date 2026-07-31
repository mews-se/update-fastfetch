#!/usr/bin/env bash

set -euo pipefail

RELEASE_BASE_URL="https://github.com/fastfetch-cli/fastfetch/releases/latest"
CURL_OPTS=(-fsSL --retry 3 --connect-timeout 10)

SUDO="sudo"
if [[ "${EUID}" -eq 0 ]]; then
    SUDO=""
fi

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

    # Raspberry Pi Zero/1 report armhf in dpkg but only support armv6,
    # so check the actual CPU before trusting dpkg's answer.
    if [[ "$uname_arch" == "armv6l" ]]; then
        echo "linux-armv6l.deb"
        return 0
    fi

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
            echo "linux-armv7l.deb"
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
        armv7l|armv7*|armhf)
            echo "linux-armv7l.deb"
            return 0
            ;;
    esac

    echo "Unsupported architecture. dpkg='${dpkg_arch:-unknown}', uname='${uname_arch:-unknown}'" >&2
    exit 1
}

fetch_latest_version() {
    local release_url
    local version

    release_url="$(curl "${CURL_OPTS[@]}" -o /dev/null -w '%{url_effective}' -I "$RELEASE_BASE_URL")"
    version="${release_url##*/}"

    if [[ -z "$version" || "$version" == "latest" ]]; then
        echo "Error: could not resolve latest Fastfetch version" >&2
        exit 1
    fi

    printf '%s\n' "$version"
}

installed_version() {
    dpkg-query -W -f='${Version}' fastfetch 2>/dev/null || true
}

main() {
    local asset_name
    local latest_version
    local current_version
    local download_url
    local temp_deb

    require_command curl
    require_command apt-get
    require_command mktemp
    if [[ -n "$SUDO" ]]; then
        require_command sudo
    fi

    asset_name="$(detect_architecture)"
    log "Detected Fastfetch asset: fastfetch-${asset_name}"

    latest_version="$(fetch_latest_version)"
    current_version="$(installed_version)"

    if [[ -n "$current_version" && "$current_version" = "$latest_version" ]]; then
        log "Fastfetch ${current_version} is already the latest version, nothing to do"
        return 0
    fi

    if [[ -n "$current_version" ]]; then
        log "Updating Fastfetch ${current_version} -> ${latest_version}"
    else
        log "Installing Fastfetch ${latest_version}"
    fi

    download_url="${RELEASE_BASE_URL}/download/fastfetch-${asset_name}"
    temp_deb="$(mktemp "/tmp/fastfetch_latest_XXXXXX_${asset_name}")"
    trap 'rm -f "$temp_deb"' EXIT

    log "Downloading package to ${temp_deb}"
    curl "${CURL_OPTS[@]}" "$download_url" -o "$temp_deb"
    # Let apt's sandbox user (_apt) read the package to avoid an unsandboxed-download warning.
    chmod 644 "$temp_deb"

    log "Installing package via apt-get"
    $SUDO apt-get install -y "$temp_deb"

    log "Fastfetch install/update complete"
}

main "$@"
