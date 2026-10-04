#!/bin/sh
set -eu

ROOT="${1:-.}"
git -C "$ROOT" submodule update --init --recursive
"$ROOT/scripts/fetch-release-src.sh" "$ROOT/sources/aarch64"

echo "Upstream source tree ready for AArch64 work."
echo "Next: build the cross/native toolchain, then the ARM kernel and initramfs."
