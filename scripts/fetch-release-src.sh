#!/bin/sh
set -eu

BASE="${TINYCORE_SRC_BASE:-https://distro.ibiblio.org/tinycorelinux/17.x/aarch64/release/src}"
ROOT="${1:-sources/aarch64}"

mkdir -p "$ROOT/toolchain"

# Tiny Core 17.x AArch64 toolchain source set.
# The mirror contains large upstream tarballs, so they are fetched into a
# source cache instead of being stored inside the Git repository.

for f in \
  XML-Parser-2.47.tar.gz \
  automake-1.18.1.tar.xz \
  bash-5.3.tar.gz \
  binutils-2.45.1.tar.xz \
  bison-3.8.2.tar.xz \
  coreutils-9.9-i18n-1.patch \
  coreutils-9.9.tar.xz \
  diffutils-3.12.tar.xz \
  e2fsprogs-1.47.3.tar.gz \
  expat-2.7.3.tar.xz \
  gawk-5.3.2.tar.xz \
  gcc-15.2.0.tar.xz \
  glibc-2.38-uclibc-compat-ld-cache.patch \
  glibc-2.42-fhs-1.patch \
  glibc-2.42-upstream_fixes-1.patch \
  glibc-2.42.tar.xz \
  glibc_Os.patch \
  gperf-3.3.tar.gz \
  grep-3.12.tar.xz \
  gzip-1.14.tar.xz \
  libffi-3.5.2.tar.gz \
  libxcrypt-4.5.2.tar.xz \
  linux-6.18.tar.xz \
  lz4-1.10.0.tar.gz \
  m4-1.4.20.tar.xz \
  mpfr-4.2.2.tar.xz \
  ncurses-6.5-20250809.tgz \
  patch-2.8.tar.xz \
  pcre2-10.47.tar.bz2 \
  perl-5.42.0.tar.xz \
  readline-8.3.tar.gz \
  util-linux-2.41.2.tar.xz \
  xz-5.8.1.tar.xz
do
  wget -c -P "$ROOT/toolchain" "$BASE/toolchain/$f"
done

echo "Tiny Core 17.x AArch64 source cache populated under $ROOT/toolchain"
