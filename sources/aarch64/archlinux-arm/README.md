# Arch Linux ARM AArch64 source/cache area

This directory is reserved for externally fetched Arch Linux ARM AArch64 material.

Do not commit generated root filesystems, package caches, or downloaded release archives unless there is an explicit reproducibility/legal reason to do so.

The bootstrap helper is:

```sh
./scripts/bootstrap-archlinux-arm-aarch64.sh
```

The default target is the generic Arch Linux ARM AArch64 release. Board-specific kernel/device-tree/bootloader sources belong in a future board-specific subtree.
