# rk3399 chipset buildroot system

Supporting some rk3399 based SbCs. Add your own variant.
Supports the NanoPi M4 and M4B hardware, easily altered to support other rk3399 boards.

# Initial setup

Clone buildroot. For example :

```
cd yourPath
git clone git://git.busybox.net/buildroot buildroot.rk3399
cd buildroot.rk3399

# tested with the following repo commit (you may be able to use HEAD)
git checkout 2021.11.2
```

Make sure you have requirements :
```
sudo apt-get install -y build-essential gcc g++ autoconf automake libtool bison flex gettext
sudo apt-get install -y patch texinfo wget git gawk curl lzma bc quilt
```

Clone the buildroot.rk3399.external external buildroot tree :
```
git clone https://github.com/flatmax/buildroot.rk3399.external.git buildroot.rk3399.external
```
# Setup for M4 or M4B versions

Change the BR2_LINUX_KERNEL_INTREE_DTS_NAME variable in the neo4_custom_defconfig file.

## To add a different rk3399 platform

Alter the BR2_LINUX_KERNEL_INTREE_DTS_NAME in the neo4_custom_defconfig file. If you have trouble booting check the u-boot BR2_TARGET_UBOOT_BOARD_DEFCONFIG variable and choose an appropriate one. Also check vars.txt for the correct dtb to load.

# To make the system

```
source buildroot.rk3399.external/setup.sh yourPath/buildroot.rk3399
```

# ensure you have your buildroot net downloads directory setup

```
mkdir yourPath/buildroot.dl
```

# build the system

```
make
```

# installing

Insert your sdcard into your drive and make sure it isn't mounted. Write the image to the disk.

NOTE: The following command will overwrite any disk attached to $OF. Don't overwrite your root.

```
OF=/dev/sdb; rootDrive=`mount | grep " / " | grep $OF`; if [ -z $rootDrive ]; then sudo umount $OF[123456789]; sudo dd if=output/images/sdcard.img of=$OF; else echo you are trying to overwrite your root drive; fi
```

# using

Connect to the console debug uart with a serial cable. Or, add the openssh-server pacakge to the buildsystem, then ssh in as user root, no pass.

# TODO
Try to move from the rockchip first stage bootloader to the uboot bootloader with BR2_TARGET_ARM_TRUSTED_FIRMWARE
