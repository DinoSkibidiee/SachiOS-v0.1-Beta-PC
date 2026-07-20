#!/bin/bash

set -e

NAME="SachiOS"
WORKDIR="$PWD/work"

echo "[+] Installing dependencies..."

sudo apt update
sudo apt install -y \
    live-build \
    debootstrap \
    squashfs-tools \
    xorriso \
    isolinux \
    syslinux-utils

echo "[+] On build..."

mkdir -p $WORKDIR
cd $WORKDIR

lb config \
    --distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --debian-installer live \
    --iso-application "$NAME"

echo "[+] Adding pkg..."

mkdir -p config/package-lists

cp ../packages.txt config/package-lists/sachios.list.chroot

echo "[+] Adding configs..."

mkdir -p config/includes.chroot/etc

cp ../configs/motd \
config/includes.chroot/etc/motd

mkdir -p config/hooks/live

cp ../scripts/postinstall.sh \
config/hooks/live/0010-postinstall.chroot

chmod +x config/hooks/live/0010-postinstall.chroot

echo "[+] Build ISO file..."

sudo lb build

echo "[+] Done!"
echo "ISO File In: $WORKDIR"
