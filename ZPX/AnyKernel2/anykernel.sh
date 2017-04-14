#!/sbin/sh

# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=rifle007 @ xda
do.devicecheck=0
do.initd=1
do.modules=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties

# shell variables
#leave blank for automatic search boot block
#block=
#is_slot_device=0;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
#add mount option while push to system
mount /system;
mount -o remount,rw /system;

chmod -R 755 $ramdisk
cp -rpf $patch/init.d /system/etc
cp -rpf $patch/cron.d /system/etc
#cp -rpf $patch/thermal-engine.conf /system/etc/thermal-engine.conf
#chmod -R 644 /system/etc/thermal-engine.conf
chmod -R 755 /system/etc/init.d
chmod -R 755 /system/etc/cron.d
chmod -R 755 modules
# cp -rf modules /system/lib
#mv /system/bin/vm_bms /system/bin/vm_bms.bak
#chmod 644 $ramdisk/sbin/media_profiles.xml


## AnyKernel install
find_boot;
dump_boot;

# begin ramdisk changes

replace_line fstab.qcom "/dev/block/zram0" "/dev/block/zram0                                  none  swap  defaults  zramsize=1073741824,zramstreams=2,notrim";

## insert extra init file init.mk.rc , init.aicp.rc , init.cm.rc
#backup_file init.rc
#insert_line init.rc "init.mk.rc" after "extra init file" "import /init.mk.rc";
#insert_line init.rc "init.aicp.rc" after "extra init file" "import /init.aicp.rc";
#insert_line init.rc "init.cm.rc" after "extra init file" "import /init.cm.rc";

## init.rc
#backup_file init.rc;
#replace_string init.rc "cpuctl cpu,timer_slack" "mount cgroup none /dev/cpuctl cpu" "mount cgroup none /dev/cpuctl cpu,timer_slack";
#append_file init.rc "run-parts" init;

## init.tuna.rc
#backup_file init.tuna.rc;
#insert_line init.tuna.rc "nodiratime barrier=0" after "mount_all /fstab.tuna" "\tmount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data remount nosuid nodev noatime nodiratime barrier=0";
#append_file init.tuna.rc "dvbootscript" init.tuna;

## init.superuser.rc
#if [ -f init.superuser.rc ]; then
#  backup_file init.superuser.rc;
#  replace_string init.superuser.rc "Superuser su_daemon" "# su daemon" "\n# Superuser su_daemon";
#  prepend_file init.superuser.rc "SuperSU daemonsu" init.superuser;
#else
#  replace_file init.superuser.rc 750 init.superuser.rc;
#  insert_line init.rc "init.superuser.rc" after "on post-fs-data" "    #import /init.superuser.rc";
#fi;

## fstab.tuna
#backup_file fstab.tuna;
#patch_fstab fstab.tuna /system ext4 options "nodiratime,barrier=0" "nodev,noatime,nodiratime,barrier=0,data=writeback,noauto_da_alloc,discard";
#patch_fstab fstab.tuna /cache ext4 options "barrier=0,nomblk_io_submit" "nosuid,nodev,noatime,nodiratime,errors=panic,barrier=0,nomblk_io_submit,data=writeback,noauto_da_alloc";
#patch_fstab fstab.tuna /data ext4 options "nomblk_io_submit,data=writeback" "nosuid,nodev,noatime,errors=panic,nomblk_io_submit,data=writeback,noauto_da_alloc";
#append_file fstab.tuna "usbdisk" fstab;

## make permissive
# Set permissive on boot - but only if not already permissive
cmdfile=`ls $split_img/*-cmdline`;
cmdtmp=`cat $cmdfile`;
case "$cmdtmp" in
  *selinux=permissive*) ;;
  *) rm $cmdfile; echo "androidboot.selinux=permissive $cmdtmp" > $cmdfile;;
esac;

## end ramdisk changes

write_boot;

## end install
