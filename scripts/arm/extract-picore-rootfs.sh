#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
IMG="${1:-$ROOT/sources/aarch64/RPi/piCore64-17.0.img.gz}"
DEST="${2:-$ROOT/build/arm64-vmware/rootfs}"

command -v guestfish >/dev/null 2>&1 || {
  echo "guestfish is required. Install libguestfs-tools in the ARM64 build container." >&2
  exit 1
}

[ -f "$IMG" ] || { echo "Missing piCore image: $IMG" >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

gunzip -c "$IMG" > "$TMP/picore.img"

PART=""
for candidate in /dev/sda1 /dev/sda2 /dev/sda3; do
  if guestfish --ro -a "$TMP/picore.img" -m "$candidate" ls /etc/os-release >/dev/null 2>&1; then
    PART="$candidate"
    break
  fi
done

[ -n "$PART" ] || {
  echo "Could not locate a Linux root filesystem in the piCore seed image." >&2
  echo "Inspect the image with: virt-filesystems -a $TMP/picore.img --all --long -h" >&2
  exit 1
}

rm -rf "$DEST"
mkdir -p "$DEST"

guestfish --ro -a "$TMP/picore.img" -m "$PART" tar-out / - | tar -xpf - -C "$DEST"

echo "Rootfs seed extracted to: $DEST"
