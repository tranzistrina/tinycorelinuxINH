# VMware Fusion ARM64 target

## First boot

Use VMware Fusion on an Apple Silicon Mac.

The guest must be ARM64/AArch64. x86 and x86_64 guests are not compatible with Apple Silicon Fusion virtualization.

Recommended initial virtual hardware:

- UEFI firmware
- 2-4 vCPUs
- 2-4 GB RAM
- NVMe virtual disk
- vmxnet3 network adapter
- 3D acceleration disabled for the first bring-up

Attach the generated ISO from `build/arm64-vmware/tinycore-arm64-vmware.iso`.

## Expected boot path

UEFI -> GRUB AA64 -> Linux 6.18 ARM64 -> Tiny Core initramfs -> simpledrm/vmwgfx -> framebuffer -> Xfbdev -> FLWM.

The first graphical milestone intentionally uses non-accelerated 2D. Broadcom documents vmwgfx as the required Linux driver for the VMware ARM graphics path; accelerated 3D additionally requires Mesa 22.1.1+.

## First console test

Before forcing GUI autostart, verify:

```sh
uname -m
cat /proc/cmdline
ls -l /dev/fb0
dmesg | grep -Ei 'vmwgfx|simpledrm|drm|fb'
```

Then load the graphical extensions from the AArch64 Tiny Core repository and run:

```sh
tce-load -w -i Xfbdev Xlibs Xprogs flwm wbar fltk-1.4
startx
```

Package names can change between Tiny Core releases. Use `tce-ab` or the repository index to resolve the current names instead of hard-coding stale URLs into the image.

## After the first successful GUI boot

Only after the framebuffer desktop is stable should we enable the accelerated VMware/Mesa path. This keeps the initial port focused on boot, input, network and a working graphical session instead of debugging three subsystems simultaneously, a cherished human tradition.
