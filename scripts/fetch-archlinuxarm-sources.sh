#!/bin/sh
set -eu

# Fetch Arch Linux ARM package recipes used as the source layer.
# This intentionally clones PKGBUILDs instead of committing binary packages.
#
# Usage:
#   ./scripts/fetch-archlinuxarm-sources.sh [output-dir]

OUT=${1:-sources/aarch64/archlinux-arm/PKGBUILDs}
REPO=${ARCHLINUXARM_PKGBUILDS_URL:-https://github.com/archlinuxarm/PKGBUILDs.git}
REF=${ARCHLINUXARM_PKGBUILDS_REF:-master}

mkdir -p "$(dirname "$OUT")"

if [ -d "$OUT/.git" ]; then
  git -C "$OUT" fetch --depth 1 origin "$REF"
  git -C "$OUT" reset --hard FETCH_HEAD
else
  git clone --depth 1 --branch "$REF" "$REPO" "$OUT"
fi

echo "Arch Linux ARM PKGBUILDs: $OUT"
git -C "$OUT" rev-parse HEAD
