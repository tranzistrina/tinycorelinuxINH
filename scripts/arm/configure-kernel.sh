#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
SRC="${1:-$ROOT/sources/aarch64/linux-6.18}"
FRAGMENT="$ROOT/configs/arm64-vmware.fragment"

[ -d "$SRC" ] || { echo "Kernel source not found: $SRC" >&2; exit 1; }
[ -f "$FRAGMENT" ] || { echo "Kernel fragment not found: $FRAGMENT" >&2; exit 1; }

cd "$SRC"
make ARCH=arm64 defconfig
./scripts/kconfig/merge_config.sh -m .config "$FRAGMENT"
make ARCH=arm64 olddefconfig

echo "VMware ARM64 kernel configuration prepared in $SRC/.config"
