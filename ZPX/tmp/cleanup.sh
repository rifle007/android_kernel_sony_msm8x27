#!/sbin/sh
#
# Hana Kernel Installer
# Cleaner Engine
# Nicklas Van Dam @ XDA
# Makihatayama Hana (2016)
# Amakura Mayu (2017)
# Rei Kurosawa (2017)
# Hana Kernel Development

# This will clean temporary kernel files...
cd /tmp
rm /tmp/runme.sh
rm /tmp/unpackbootimg
rm /tmp/mkbootimg
rm /tmp/boot.img
rm /tmp/boot.img-base
rm /tmp/boot.img-board
rm /tmp/boot.img-cmdline
rm /tmp/boot.img-kerneloff
rm /tmp/boot.img-pagesize
rm /tmp/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdiskoff
rm /tmp/boot.img-tagsoff
rm /tmp/boot.img-zImage
rm /tmp/createnewboot.sh
rm /tmp/newboot.img
rm -rvf /tmp/kernel

exit 0
