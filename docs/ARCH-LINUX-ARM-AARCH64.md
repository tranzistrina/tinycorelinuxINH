# Arch Linux ARM / AArch64 modernization baseline

Arch Linux itself officially supports x86_64. ARM is provided by the community-maintained Arch Linux ARM project, which provides optimized ARMv7 and ARMv8/AArch64 packages and device-specific installation images.

For this project the primary ARM target is **AArch64 (ARMv8)**.

## Source strategy

Do not vendor a binary Arch Linux ARM root filesystem into this repository.

Instead, keep reproducible metadata and scripts that can fetch/build the userland later:

- Arch Linux ARM AArch64 as the reference external userland.
- Tiny Core Linux 17.1 boot/core scripts remain the upstream base.
- ARM-specific kernel, firmware and device-tree material must live in a board-specific layer.
- Generated root filesystems and package caches stay outside Git.

## Why AArch64 first

AArch64 is the current 64-bit ARM target and is the cleanest basis for modernization. Arch Linux ARM publishes a generic AArch64 multi-platform root filesystem as well as hardware-specific images.

For portability, the generic AArch64 package/userland model should be preferred, while kernel/DTB/bootloader handling is kept board-specific.

## Intended project layering

```
Tiny Core 17.1
    |
    +-- INH base changes
    |
    +-- ARM/AArch64 compatibility layer
    |      +-- toolchain/build configuration
    |      +-- kernel interface
    |      +-- init/boot adaptations
    |
    +-- Arch Linux ARM AArch64 userland integration
    |
    +-- board support
    |      +-- bootloader
    |      +-- kernel config
    |      +-- device tree
    |      +-- firmware
    |
    +-- regional/CIS layer
```

## Important distinction

Arch Linux ARM is a distribution/port of Arch Linux for ARM. It is **not** the official Arch Linux architecture set maintained by the Arch Linux project itself.

Consequently, this branch should treat Arch Linux ARM as an external upstream dependency/reference, not as a replacement for Tiny Core's own upstream source tree.

## References

- Arch Linux ARM: https://archlinuxarm.org/
- Arch Linux ARM downloads: https://archlinuxarm.org/about/downloads
- Arch Linux architecture FAQ: https://wiki.archlinux.org/title/Frequently_asked_questions
