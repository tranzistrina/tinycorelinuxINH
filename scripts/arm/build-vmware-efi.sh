#!/bin/sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)"
OUT="$ROOT/build/arm64-vmware"
KERNEL="${KERNEL:-$OUT/kernel/Image}"
CORE="${CORE:-$OUT/core.gz}"
ISO="${ISO:-$OUT/tinycore-arm64-vmware.iso}"

command -v grub-mkstandalone >/dev/null 2>&1 || {
  echo "grub-mkstandalone is required (grub-efi-arm64-bin)." >&2
  exit 1
}
command -v xorriso >/dev/null 2>&1 || {
  echo "xorriso is required." >&2
  exit 1
}

[ -f "$KERNEL" ] || { echo "Missing kernel: $KERNEL" >&2; exit 1; }
[ -f "$CORE" ] || {
  echo "Missing initramfs: $CORE" >&2
  echo "Provide a Tiny Core AArch64 core.gz built from the ARM rootfs layer." >&2
  exit 1
}

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/boot" "$STAGE/EFI/BOOT" "$STAGE/boot/grub"
cp "$KERNEL" "$STAGE/boot/Image"
cp "$CORE" "$STAGE/boot/core.gz"
cp "$ROOT/vmware/grub.cfg" "$STAGE/boot/grub/grub.cfg"

grub-mkstandalone \
  -O arm64-efi \
  -o "$STAGE/EFI/BOOT/BOOTAA64.EFI" \
  --modules="part_gpt fat ext2 normal linux" \
  "boot/grub/grub.cfg=$ROOT/vmware/grub.cfg"

mkdir -p "$(dirname "$ISO")"
xorriso -as mkisofs \
  -R -J -V TINYCORE_ARM64_VMWARE \
  -e EFI/BOOT/BOOTAA64.EFI \
  -no-emul-boot \
  -o "$ISO" "$STAGE"

echo "VMware ARM64 UEFI ISO: $ISO"
