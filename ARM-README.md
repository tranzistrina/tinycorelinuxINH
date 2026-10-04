# ARM branch

This branch targets **Tiny Core Linux on AArch64 in VMware Fusion on Apple Silicon Macs**.

## Objective

Get a reproducible graphical ARM64 Tiny Core guest running under VMware Fusion first. Hardware-board support and regional/CIS changes stay out of this branch until the VM target is stable.

## Commands on an Apple Silicon Mac

Use a native ARM64 Linux build container:

```sh
docker run --rm -it --platform linux/arm64 \
  -v "$PWD":/src -w /src \
  debian:bookworm-slim bash
```

Inside the container:

```sh
apt-get update
apt-get install -y \
  build-essential bc bison flex libssl-dev libelf-dev \
  cpio xz-utils gzip wget ca-certificates \
  grub-efi-arm64-bin grub-common xorriso \
  libguestfs-tools

git submodule update --init --recursive
./scripts/arm/bootstrap-vmware.sh
./scripts/arm/build-vmware-efi.sh
```

The bootstrap downloads the official Tiny Core AArch64 toolchain/source set and the official piCore64 17.0 AArch64 image used only as a userspace seed.

## Why piCore 17.0 is only a seed

The official AArch64 release currently publishes a piCore64 17.0 image, while the generic AArch64 release source tree provides the 17.x toolchain sources. The Raspberry Pi image is not assumed to be directly bootable under VMware's UEFI firmware.

The VMware kernel is built separately from the generic AArch64 Linux 6.18 source and configured for VMware virtual hardware.

## Graphics strategy

Stage 1:
- EFI
- simpledrm
- vmwgfx
- fbdev emulation
- Xfbdev
- FLTK/FLWM

Stage 2:
- Mesa
- accelerated VMware 3D
- dynamic resolution

Do not make Stage 2 a prerequisite for the first boot.

## Known limitation

The current ARM bootstrap creates the kernel/initramfs/EFI pipeline but does not claim to have a verified final graphical ISO yet. The exact userspace extraction format of the current piCore seed must be validated once inside the ARM64 build container.

That is deliberate. An unverified image that merely exists is less useful than a build that fails loudly at the actual missing layer.
