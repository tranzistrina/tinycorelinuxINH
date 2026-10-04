# TinyCore Linux INH

Исходная база для портирования и модернизации Tiny Core Linux 17.1 под ARM/AArch64 и последующей региональной адаптации.

## Что уже находится в репозитории

- Полный upstream Core-scripts в upstream/Core-scripts/, включая загрузочные скрипты, tce-*, udev и системные утилиты.
- tinyx, flwm и fltk_projects закреплены как Git submodules на конкретных upstream-коммитах.
- Документация по ARM/AArch64 портированию в docs/PORT-ARM-AARCH64.md.
- Скрипты подготовки и загрузки официальных AArch64 source archives в scripts/.
- Отдельный каталог sources/aarch64/ для внешних исходников, которые нецелесообразно хранить внутри Git из-за размера.

## Быстрый старт

```sh
git clone https://github.com/tranzistrina/tinycorelinuxINH.git
cd tinycorelinuxINH
git submodule update --init --recursive
./scripts/bootstrap-aarch64.sh
```

После этого исходная база Tiny Core и AArch64 toolchain sources будут готовы к разработке.

## Upstream Tiny Core Linux

Релизная база: Tiny Core Linux 17.1.

Официальный релиз:
https://forum.tinycorelinux.net/index.php?topic=28211.0

Официальный GitHub:
- https://github.com/tinycorelinux/Core-scripts
- https://github.com/tinycorelinux/tinyx
- https://github.com/tinycorelinux/flwm
- https://github.com/tinycorelinux/fltk_projects

Официальные release sources:
- https://distro.ibiblio.org/tinycorelinux/17.x/aarch64/release/src/
- https://distro.ibiblio.org/tinycorelinux/17.x/x86/release/src/
- https://distro.ibiblio.org/tinycorelinux/17.x/x86_64/release/src/

## ARM стратегия

Первичная цель: AArch64 / ARMv8.

Сначала сохраняем совместимость с upstream Tiny Core, затем отдельным слоем добавляем:
- русскую локализацию и раскладки;
- шрифты и полноценную работу с кириллицей;
- региональные настройки времени и локали;
- локальные зеркала и правила доступа к пакетам;
- дополнительные корневые сертификаты и корпоративные настройки;
- board-specific kernel/device-tree support.

Не смешивать региональную политику с базовым boot-кодом без необходимости.

## Важное ограничение

Большие официальные source archives не коммитятся в Git. Они скачиваются скриптом из официального Tiny Core mirror, чтобы репозиторий не превращался в склад 100+ MB tarball'ов. Это относится, в частности, к GCC 15.2.0, glibc 2.42 и Linux 6.18.

Для конкретной платы позже потребуется отдельный kernel config/device-tree слой. Официальная AArch64 публикация Tiny Core содержит отдельный Raspberry Pi/piCore набор, а не универсальный готовый kernel config для любого ARM board.

## Лицензии и provenance

Upstream copyright notices и лицензии сохраняются. Изменения для INH/ARM/CIS должны идти отдельными коммитами или слоями поверх upstream-кода.