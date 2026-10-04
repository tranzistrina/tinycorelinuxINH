# TinyCore Linux INH

Исходная база для последующей модернизации Tiny Core Linux.

## Upstream

Официальный проект Tiny Core Linux не представляет весь дистрибутив одним Git-репозиторием. Основные исходные компоненты находятся в нескольких upstream-репозиториях, а release-specific исходники и патчи публикуются в каталоге `release/src` официального зеркала.

### Baseline

- Tiny Core Linux: 17.1
- Архитектуры: x86, x86_64
- Официальный сайт: http://tinycorelinux.net/
- Официальное обсуждение релиза 17.1: https://forum.tinycorelinux.net/index.php?topic=28211.0

### Upstream Git repositories

- Core-scripts: https://github.com/tinycorelinux/Core-scripts
- fltk_projects: https://github.com/tinycorelinux/fltk_projects
- tinyx: https://github.com/tinycorelinux/tinyx
- flwm: https://github.com/tinycorelinux/flwm

### Release source

Release-specific source archives, patches and kernel source/config are published under:

- http://tinycorelinux.net/17.x/x86/release/src/
- http://tinycorelinux.net/17.x/x86_64/release/src/

## Import policy

This repository will keep upstream sources separated from modernization work. Upstream licenses and copyright notices must remain intact. New modifications will be committed separately.

## First modernization target

Preserve a reproducible upstream baseline, then build a documented toolchain and image-generation workflow around it.
