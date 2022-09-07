# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=VantomLillia by Adrian and Steve based on Vantomkernel
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=davinci
device.name2=davinciin
supported.versions=11 - 13
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

ui_print " " "Checking FileSystem type for /system..."
# FS_Check
slot=$(getprop ro.boot.slot_suffix)
dd if=/dev/block/by-name/system$slot bs=8 skip=135 count=1 | xxd | grep -q 53ef
case $? in
    0)
        ui_print " " "EXT4 system partition detected! Using EXT4 patched dtb..."
        cp $home/dtbs/dtb.img $home/dtb.img
        ;;
    1)
        ui_print " " "EROFS system partition detected! Using EROFS patched dtb..."
        cp $home/dtbs/dtb_erofs.img $home/dtb.img
        ;;
esac

## AnyKernel install
dump_boot;

# begin ramdisk changes

# end ramdisk changes

write_boot;
## end install
