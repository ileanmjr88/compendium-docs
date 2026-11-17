#!/bin/sh
# Compendium installer.
#
# Usage:
#   curl -fsSL https://compendium.ilean.me/install.sh | sh
#
# Optional environment overrides:
#   COMPENDIUM_VERSION=v0.1.0  # pin a specific release (default: latest)
#   INSTALL_DIR=$HOME/bin      # install location (default: $HOME/.local/bin)
#   COMPENDIUM_DOC_DIR=...     # license files (default: $XDG_DATA_HOME/doc/compendium,
#                              #   or $HOME/.local/share/doc/compendium)

set -eu

REPO="ileanmjr88/compendium"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
DOC_DIR="${COMPENDIUM_DOC_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/doc/compendium}"
VERSION="${COMPENDIUM_VERSION:-}"

# ---- helpers ---------------------------------------------------------------

info()    { printf '\033[34m→\033[0m %s\n' "$*"; }
success() { printf '\033[32m✓\033[0m %s\n' "$*"; }
warn()    { printf '\033[33m!\033[0m %s\n' "$*" >&2; }
fail()    { printf '\033[31m✗\033[0m %s\n' "$*" >&2; exit 1; }

need() {
    command -v "$1" >/dev/null 2>&1 || fail "$1 is required but not installed"
}

# v0.1.2 and later are Apache-2.0 and must ship LICENSE, NOTICE and
# third_party_licenses/. v0.1.1 and earlier (GPL-3.0) predate that.
# An unparseable version is treated as new, so the check stays on.
needs_license_files() {
    core="${1%%-*}"
    major="${core%%.*}"; rest="${core#*.}"
    minor="${rest%%.*}"; patch="${rest#*.}"
    case "${major}${minor}${patch}" in
        ''|*[!0-9]*) return 0 ;;
    esac
    [ "$major" -gt 0 ] || [ "$minor" -gt 1 ] || { [ "$minor" -eq 1 ] && [ "$patch" -ge 2 ]; }
}

# ---- prereq checks ---------------------------------------------------------

need curl
need tar
need uname

# ---- detect platform -------------------------------------------------------

case "$(uname -s)" in
    Darwin) os=darwin ;;
    Linux)  os=linux ;;
    *)      fail "unsupported OS: $(uname -s) (need darwin or linux)" ;;
esac

case "$(uname -m)" in
    x86_64|amd64)  arch=amd64 ;;
    arm64|aarch64) arch=arm64 ;;
    *)             fail "unsupported architecture: $(uname -m) (need amd64 or arm64)" ;;
esac

# Pick the right SHA256 tool.
if command -v sha256sum >/dev/null 2>&1; then
    sha256() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
    sha256() { shasum -a 256 "$1" | awk '{print $1}'; }
else
    fail "neither sha256sum nor shasum found"
fi

# ---- resolve version -------------------------------------------------------

if [ -z "$VERSION" ]; then
    info "resolving latest release"
    VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
        | grep '"tag_name"' \
        | head -1 \
        | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')
    [ -n "$VERSION" ] || fail "failed to resolve latest release"
fi

version_no_v="${VERSION#v}"

tarball="compendium_${version_no_v}_${os}_${arch}.tar.gz"
download_url="https://github.com/${REPO}/releases/download/${VERSION}/${tarball}"
checksums_url="https://github.com/${REPO}/releases/download/${VERSION}/checksums.txt"

# ---- download --------------------------------------------------------------

tmp=$(mktemp -d 2>/dev/null || mktemp -d -t compendium-install)
trap 'rm -rf "$tmp"' EXIT INT TERM

info "downloading ${tarball}"
curl -fL --progress-bar -o "$tmp/$tarball" "$download_url" \
    || fail "failed to download $download_url"

info "downloading checksums.txt"
curl -fsSL -o "$tmp/checksums.txt" "$checksums_url" \
    || fail "failed to download $checksums_url"

# ---- verify ----------------------------------------------------------------

info "verifying checksum"
expected=$(awk -v f="$tarball" '$2 == f { print $1 }' "$tmp/checksums.txt")
[ -n "$expected" ] || fail "no checksum entry for $tarball in checksums.txt"

actual=$(sha256 "$tmp/$tarball")
[ "$expected" = "$actual" ] || fail "checksum mismatch
  expected: $expected
  actual:   $actual"

# ---- install ---------------------------------------------------------------

info "extracting"
tar -xzf "$tmp/$tarball" -C "$tmp"
[ -f "$tmp/compendium" ] || fail "tarball did not contain a 'compendium' binary"

if needs_license_files "$version_no_v"; then
    info "verifying license files"
    [ -f "$tmp/LICENSE" ] || fail "tarball did not contain LICENSE"
    [ -f "$tmp/NOTICE" ]  || fail "tarball did not contain NOTICE"
    if [ ! -d "$tmp/third_party_licenses" ] || [ -z "$(ls -A "$tmp/third_party_licenses")" ]; then
        fail "tarball did not contain third_party_licenses/"
    fi
fi

mkdir -p "$INSTALL_DIR"
cp "$tmp/compendium" "$INSTALL_DIR/compendium"
chmod 0755 "$INSTALL_DIR/compendium"

# Strip macOS quarantine if curl set it.
if [ "$os" = "darwin" ] && command -v xattr >/dev/null 2>&1; then
    xattr -d com.apple.quarantine "$INSTALL_DIR/compendium" 2>/dev/null || true
fi

success "installed compendium ${VERSION} to ${INSTALL_DIR}/compendium"

# Replace any license files from a previous install so they always match
# the installed version.
mkdir -p "$DOC_DIR"
rm -rf "$DOC_DIR/LICENSE" "$DOC_DIR/NOTICE" "$DOC_DIR/third_party_licenses"
for f in LICENSE NOTICE; do
    if [ -f "$tmp/$f" ]; then
        cp "$tmp/$f" "$DOC_DIR/$f"
    fi
done
if [ -d "$tmp/third_party_licenses" ]; then
    cp -R "$tmp/third_party_licenses" "$DOC_DIR/third_party_licenses"
fi

success "license files in ${DOC_DIR}"

# ---- PATH hint -------------------------------------------------------------

case ":$PATH:" in
    *":${INSTALL_DIR}:"*) ;;
    *)
        printf '\n'
        warn "${INSTALL_DIR} is not on your PATH"
        printf '    add this line to your shell profile:\n'
        printf '\n      export PATH="%s:$PATH"\n\n' "$INSTALL_DIR"
        ;;
esac

# ---- next steps ------------------------------------------------------------

printf '\nrun "compendium version" to verify the install.\n'
