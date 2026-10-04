#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
SRC="$ROOT/sources/aarch64/linux-6.18"
ARCHIVE="$ROOT/sources/aarch64/toolchain/linux-6.18.tar.xz"
OUT="$ROOT/build/arm64-vmware/kernel"

mkdir -p "$ROOT/sources/aarch64" "$ROOT/build/arm64-vmware" "$OUT"

if [ ! -d "$SRC" ]; then
  [ -f "$ARCHIVE" ] || "$ROOT/scripts/fetch-release-src.sh" "$ROOT/sources/aarch64"
  tar -xJf "$ARCHIVE" -C "$ROOT/sources/aarch64"
  FOUND="$(find "$ROOT/sources/aarch64" -maxdepth 1 -type d -name 'linux-6.18*' | head -n 1)"
  [ -n "$FOUND" ] || { echo "Unable to locate extracted Linux 6.18 source" >&2; exit 1; }
  [ "$FOUND" = "$SRC" ] || mv "$FOUND" "$SRC"
fi

"$ROOT/scripts/arm/configure-kernel.sh" "$SRC"

cd "$SRC"
JOBS="${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 2)}"
make ARCH=arm64 -j"$JOBS" Image modules

cp -f arch/arm64/boot/Image "$OUT/Image"
[ -f System.map ] && cp -f System.map "$OUT/System.map" || true
cp -f .config "$OUT/kernel.config"

echo "Kernel: $OUT/Image"
