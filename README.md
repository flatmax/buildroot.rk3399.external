# NanoPi Neo4 buildroot system

Successfully build sdcards or use fastboot with this repo for the Friendly ARM Nano Pi M4. The boot system is setup for device tree overlay loading and application. The build uses the mainline Linux kernel and mainline uboot.

# Initial setup

Clone buildroot. For example :

```
cd yourPath
git clone git://git.busybox.net/buildroot buildroot.neo4
cd buildroot.neo4

# tested with the following repo commit
git checkout 34cce93adb06608992023c44fa3245d1f1a3deb4
```

Make sure you have requirements :
```
sudo apt-get install -y build-essential gcc g++ autoconf automake libtool bison flex gettext
sudo apt-get install -y patch texinfo wget git gawk curl lzma bc quilt
```

Clone the NanoPi.Neo4 external buildroot tree :
```
git clone git@github.com:flatmax/NanoPi.Neo4.buildroot.external.git NanoPi.Neo4
```

# To make the system

```
. NanoPi.Neo4/setup.sh yourPath/buildroot.neo4
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
