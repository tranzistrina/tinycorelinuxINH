#!/bin/sh
set -eu

# Prepare an external Arch Linux ARM AArch64 rootfs cache.
# No binary rootfs is committed to Git.
#
# Usage:
#   ./scripts/bootstrap-archlinux-arm-aarch64.sh [output-dir]
#
# The generic AArch64 release is selected because board-specific kernels/DTBs
# belong to the board support layer.

OUT=${1:-sources/aarch64/archlinux-arm}
BASE_URL=${ARCHLINUXARM_BASE_URL:-https://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz}

mkdir -p "$OUT"

TARBALL="$OUT/ArchLinuxARM-aarch64-latest.tar.gz"
if [ ! -f "$TARBALL" ]; then
  echo "Downloading Arch Linux ARM AArch64 rootfs metadata/source archive..."
  curl -L --fail --retry 3 "$BASE_URL" -o "$TARBALL"
else
  echo "Using cached $TARBALL"
fi

echo "Archive: $TARBALL"
echo "Next step: unpack into a staging rootfs and apply the INH ARM layer."
