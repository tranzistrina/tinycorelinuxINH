#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
ROOTFS="${1:-$ROOT/build/arm64-vmware/rootfs}"
OUT="${2:-$ROOT/build/arm64-vmware/core.gz}"

[ -d "$ROOTFS" ] || { echo "Rootfs directory not found: $ROOTFS" >&2; exit 1; }
[ -x "$ROOTFS/init" ] || {
  echo "Rootfs does not contain /init. Extract a Tiny Core AArch64 userspace seed first." >&2
  exit 1
}
command -v cpio >/dev/null 2>&1 || { echo "cpio is required" >&2; exit 1; }
command -v gzip >/dev/null 2>&1 || { echo "gzip is required" >&2; exit 1; }

mkdir -p "$(dirname "$OUT")"
(
  cd "$ROOTFS"
  find . -xdev -print0 | cpio --null -o --format=newc
) | gzip -9 > "$OUT"

echo "Tiny Core initramfs: $OUT"
