#!/bin/sh
set -eu

BASE="${TINYCORE_SRC_BASE:-https://distro.ibiblio.org/tinycorelinux/17.x/aarch64/release/src}"
ROOT="${1:-sources/aarch64}"

mkdir -p "$ROOT/toolchain"

# Toolchain sources published by Tiny Core 17.x for AArch64.
# They are intentionally fetched rather than vendored into Git because several
# individual archives are tens or hundreds of megabytes.
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/binutils-2.45.1.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/gcc-15.2.0.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/glibc-2.42.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/linux-6.18.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/bash-5.3.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/coreutils-9.9.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/e2fsprogs-1.47.3.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/expat-2.7.3.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/gawk-5.3.2.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/grep-3.12.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/gzip-1.14.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/libffi-3.5.2.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/libxcrypt-4.5.2.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/lz4-1.10.0.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/m4-1.4.20.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/mpfr-4.2.2.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/ncurses-6.5-20250809.tgz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/pcre2-10.47.tar.bz2"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/perl-5.42.0.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/readline-8.3.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/util-linux-2.41.2.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/xz-5.8.1.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/automake-1.18.1.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/bison-3.8.2.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/diffutils-3.12.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/gperf-3.3.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/patch-2.8.tar.xz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/XML-Parser-2.47.tar.gz"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/glibc-2.42-fhs-1.patch"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/glibc-2.42-upstream_fixes-1.patch"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/glibc_Os.patch"
wget -c -P "$ROOT/toolchain" "$BASE/toolchain/coreutils-9.9-i18n-1.patch"

echo "AArch64 Tiny Core source cache populated under $ROOT"
