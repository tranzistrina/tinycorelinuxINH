# Tiny Core Linux ARM/AArch64 port baseline

This branch tracks Tiny Core Linux 17.1 as the modernization baseline.

## Upstream components

Core-scripts is vendored under `upstream/Core-scripts` at upstream commit `dd2d15f6d8dc65517ff75fb088df0fd54d926c62`.

The larger graphics/UI projects are pinned as submodules:
- tinyx: `feab72ca891bc04b18763763e15ee4e532369cdf`
- flwm: `196f61c036ef65d65d5ec4095667f9a2d21822e2`
- fltk_projects: `a0b7bde55e418e78facc1dd3f2adf1c5ea671762`

## ARM strategy

Primary target: AArch64 (ARMv8).

Use the official Tiny Core 17.x AArch64 source mirror as the reference source set. It currently publishes the 17.x AArch64 toolchain sources, including GCC 15.2.0, glibc 2.42, binutils 2.45.1 and Linux 6.18 source. The same mirror also publishes Raspberry Pi-specific 6.18.37 piCore-v8 kernel sources/configuration; these are hardware-specific and should not be treated as the generic ARM kernel.

## CIS/Russian adaptation

The base should remain compatible with upstream Tiny Core semantics. CIS-specific work belongs in a separate layer:
- Russian locale and keyboard defaults
- Cyrillic font coverage
- RU mirror configuration
- timezone defaults appropriate to the target deployment
- optional local CA certificates and repository policy
- documentation and package metadata in Russian

Do not hard-code regional policy into low-level boot code unless it is required for boot.

## Reproducible source fetching

Use `scripts/fetch-release-src.sh` to populate the external source archive cache from the official Tiny Core mirror.
