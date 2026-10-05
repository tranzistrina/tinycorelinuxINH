# VMware Fusion on Apple Silicon: AArch64 target

This is the intended runtime target for the `arm/archlinux-aarch64` branch.

## Target

- Host: Apple Silicon Mac (including the M-series MacBook Air).
- Hypervisor: VMware Fusion.
- Guest CPU architecture: ARM64 / AArch64.
- Firmware: UEFI / EFI.
- Guest platform: generic AArch64, not Raspberry Pi or another physical ARM board.
- Primary userland reference: Arch Linux ARM generic AArch64.
- Existing Tiny Core Linux 17.1 sources remain the base for the INH modernization layer.

VMware Fusion on Apple Silicon supports 64-bit ARM guests and does not run x86 guests on the Apple Silicon host. Therefore this branch must stay AArch64-native end to end.

## Why the generic Arch Linux ARM release is the right base

Arch Linux ARM publishes a Generic AArch64 installation specifically for developers who can provide their own boot setup. It uses the mainline Linux kernel, and its `linux-aarch64` package includes an EFI-stubbed kernel image that can be directly booted.

That matches the VMware use case well: VMware supplies the virtual ARM machine, so there is no reason to carry a Raspberry Pi/DTB-specific kernel layer.

## VMware-specific consequences

Do not build this branch around:

- Raspberry Pi firmware;
- U-Boot board configuration;
- board-specific device trees;
- physical ARM SoC peripherals.

Instead, the first boot target should be:

```text
UEFI
  -> AArch64 EFI-stub kernel
  -> initramfs
  -> root filesystem
  -> Tiny Core / INH userspace
```

Network support should prioritize the virtual NIC exposed by Fusion (VMware paravirtual networking where available). Graphics should initially rely on the generic EFI framebuffer and then be enhanced with the VMware-compatible Linux graphics stack as supported by the guest kernel and Mesa.

## Source provenance

The Arch Linux ARM source layer is maintained separately from the binary root filesystem:

- Arch Linux ARM package modifications: https://github.com/archlinuxarm/PKGBUILDs
- Generic AArch64 installation: https://archlinuxarm.org/platforms/armv8/generic
- Arch Linux ARM downloads: https://archlinuxarm.org/about/downloads
- Linux kernel: https://kernel.org/

The repository must not commit the generated root filesystem or package cache.

## Build philosophy

Keep three layers separate:

1. Upstream Tiny Core 17.1 — boot/core behavior and original source.
2. INH AArch64/VMware layer — architecture and VM integration changes.
3. Optional Arch Linux ARM userland layer — packages and package recipes used to assemble the modernized userspace.

This makes it possible to test VMware boot behavior without permanently entangling upstream Tiny Core code with Arch-specific packaging.