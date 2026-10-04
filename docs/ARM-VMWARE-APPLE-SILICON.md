# ARM / VMware Fusion on Apple Silicon

## Target

- Host: Apple Silicon Mac, including the M5 generation
- Hypervisor: VMware Fusion for Apple Silicon
- Guest: Tiny Core Linux, AArch64
- Firmware: UEFI
- First graphics target: vmwgfx + fbdev/Xfbdev, without mandatory 3D acceleration
- Later graphics target: vmwgfx + Mesa + FLTK/FLWM accelerated path

VMware Fusion on Apple Silicon only runs 64-bit Arm guests. Broadcom documents that Linux guests on Fusion ARM should use a kernel 5.19+ for the best graphics path. Non-accelerated 2D requires the vmwgfx driver, while accelerated 3D also requires Mesa 22.1.1 or newer. EFI graphics is supported with current kernels. See the upstream Broadcom compatibility notes before changing the VM device model.

## VM settings

Create a new VM in VMware Fusion and select an ARM64/AArch64 Linux guest.

Recommended initial settings:

- Firmware: UEFI
- CPU: 2-4 virtual CPUs
- RAM: 2-4 GB
- Storage: NVMe virtual disk
- Network: VMware vmxnet3
- CD/DVD: optional, only for bootstrap ISO
- 3D acceleration: OFF for the first bring-up

Do not select an x86/x86_64 guest. Fusion on Apple Silicon cannot execute an x86 guest OS.

## Kernel features

The ARM branch enables the minimum set required for the VMware target:

- EFI stub
- DRM simple framebuffer
- VMware SVGA / vmwgfx
- DRM fbdev emulation
- NVMe storage
- vmxnet3 networking
- USB xHCI/HID/input
- framebuffer console

## First graphical boot

The first milestone is deliberately conservative:

1. UEFI boots the ARM64 kernel.
2. Tiny Core initramfs starts.
3. VMware display becomes /dev/fb0 through simpledrm or vmwgfx.
4. Xfbdev starts against /dev/fb0.
5. FLWM and the Tiny Core FLTK applications start.

This avoids making the first boot depend on Mesa or 3D acceleration. Once this is stable, the accelerated path can be added.

## ARM upstream status

Tiny Core publishes an AArch64 17.x toolchain source set, including GCC 15.2.0, glibc 2.42, binutils 2.45.1 and Linux 6.18. The official AArch64 RPi release currently publishes piCore64-17.0 as a ready-made image. The VM branch uses the AArch64 source set but does not assume that the Raspberry Pi boot firmware works under VMware UEFI.

## Build environment on the Mac

The recommended build environment is a native ARM64 Linux container on the Apple Silicon Mac, using Docker Desktop. This keeps the Linux build toolchain separate from macOS and avoids x86 emulation.

```sh
git clone https://github.com/tranzistrina/tinycorelinuxINH.git
cd tinycorelinuxINH
git checkout ARM
git submodule update --init --recursive

docker run --rm -it --platform linux/arm64 \
  -v "$PWD":/src -w /src debian:bookworm-slim bash
```

Inside the container install the standard kernel/EFI build dependencies, then run the scripts in scripts/arm/.

## Files in this branch

- configs/arm64-vmware.fragment
- scripts/arm/configure-kernel.sh
- scripts/arm/build-kernel.sh
- scripts/arm/fetch-picore-base.sh
- scripts/arm/build-vmware-efi.sh
- vmware/grub.cfg

## Important limitation

VMware's current ARM graphics stack is not identical to a physical Raspberry Pi GPU. Therefore the Raspberry Pi kernel/device-tree configuration must not simply be copied to this VM. The target is a generic ARM64 UEFI kernel with VMware virtual hardware support.