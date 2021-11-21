# rk3399 chipset buildroot system

Supporting some rk3399 based SbCs. Add your own variant.

# Initial setup

Clone buildroot. For example :

```
cd yourPath
git clone git://git.busybox.net/buildroot buildroot.rk3399
cd buildroot.rk3399

# tested with the following repo commit
git checkout 34cce93adb06608992023c44fa3245d1f1a3deb4
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

# To make the system

```
. buildroot.rk3399.external/setup.sh yourPath/buildroot.rk3399
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
OF=/dev/sdf; rootDrive=`mount | grep " / " | grep $OF`; if [ -z $rootDrive ]; then sudo umount $OF[123456789]; sudo dd if=output/images/sdcard.img of=$OF; else echo you are trying to overwrite your root drive; fi
```

# using

Connect to the console debug uart with a serial cable. Or, add the openssh-server pacakge to the buildsystem, then ssh in as user root, no pass.

# TODO
Try to move from the rockchip first stage bootloader to the uboot bootloader with BR2_TARGET_ARM_TRUSTED_FIRMWARE
