#!/sbin/sh
# ZPX kernel
# Base from Hana Kernel Installer
# Anykernel inline kernel patching script
# Nicklas Van Dam @ XDA
# Makihatayama Hana (2016)
# Amakura Mayu (2017)
# Rei Kurosawa (2017)
# Hana Kernel Development
# Ported from nexus 4 Quadra kernel

# Preparing...
cd /tmp
chmod 0755 unpackbootimg
chmod 0755 mkbootimg

# Unpack the stock kernel...
dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=/tmp/boot.img
./unpackbootimg -i boot.img

# Extracting ZPX Kernel...
rm /tmp/boot.img-zImage
cp /tmp/kernel/boot.img-zImage /tmp/boot.img-zImage

# Define the kernel's attributes for the repacking...
KERNEL_CMDLINE=`cat boot.img-cmdline | sed 's/.*/"&"/'`
KERNEL_BASE=`cat boot.img-base`
KERNEL_PAGESIZE=`cat boot.img-pagesize`
KERNEL_OFFSET=`cat boot.img-kerneloff`
RAMDISK_OFFSET=`cat boot.img-ramdiskoff`

# Create boot.img...
echo \#!/sbin/sh > createnewboot.sh
echo "./mkbootimg --kernel boot.img-zImage --ramdisk boot.img-ramdisk.gz --cmdline $KERNEL_CMDLINE --base $KERNEL_BASE --pagesize $KERNEL_PAGESIZE --kernel_offset $KERNEL_OFFSET --ramdisk_offset $RAMDISK_OFFSET -o newboot.img" >> createnewboot.sh
chmod 0755 createnewboot.sh
./createnewboot.sh

# Flashing new boot.img...
echo Flashing boot.img...
dd if=newboot.img of=/dev/block/platform/msm_sdcc.1/by-name/boot

exit 0
