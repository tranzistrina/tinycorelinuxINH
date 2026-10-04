#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
DEST="${1:-$ROOT/sources/aarch64/RPi}"
BASE="${TINYCORE_ARM_BASE:-https://distro.ibiblio.org/tinycorelinux/17.x/aarch64/release/RPi}"
IMG="piCore64-17.0.img.gz"

mkdir -p "$DEST"
wget -c -P "$DEST" "$BASE/$IMG"
wget -c -P "$DEST" "$BASE/$IMG.sha256"

cd "$DEST"
sha256sum -c "$IMG.sha256"

echo
echo "Downloaded official Tiny Core AArch64 piCore64 17.0 seed image."
echo "This Raspberry Pi image is a USERSpace seed only; do not expect its firmware/kernel"
echo "to boot directly under VMware Fusion UEFI on Apple Silicon."
