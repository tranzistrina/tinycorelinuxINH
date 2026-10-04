# Tiny Core 17.x AArch64 source cache

Official source root:

https://distro.ibiblio.org/tinycorelinux/17.x/aarch64/release/src/

The current upstream mirror publishes:
- a generic AArch64 toolchain source set
- Linux 6.18 source
- Raspberry Pi-specific kernel configs and patched kernel archives for piCore

Large archives are downloaded by `scripts/fetch-release-src.sh` rather than stored in Git.
