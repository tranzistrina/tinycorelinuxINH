#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"

echo "== 1/5: fetch AArch64 release sources =="
"$ROOT/scripts/fetch-release-src.sh" "$ROOT/sources/aarch64"

echo "== 2/5: fetch official piCore64 userspace seed =="
"$ROOT/scripts/arm/fetch-picore-base.sh"

echo "== 3/5: extract a Tiny Core AArch64 rootfs seed =="
"$ROOT/scripts/arm/extract-picore-rootfs.sh"

echo "== 4/5: create core.gz =="
"$ROOT/scripts/arm/make-core-gz.sh"

echo "== 5/5: build ARM64 VMware kernel =="
"$ROOT/scripts/arm/build-kernel.sh"

echo
echo "The kernel and initramfs are ready."
echo "Next, run scripts/arm/build-vmware-efi.sh after installing GRUB EFI and xorriso."
