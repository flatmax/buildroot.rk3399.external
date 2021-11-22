#!/usr/bin/env bash
BINARIES_DIR=$1 # first argument is the base binaries directory
PLAT=$2 # second argument is the platform name
LINUX_DIR=$3 # third argument is the linux src directory
MODEL=$4 # the third argument is the model
MKIMAGE=$5
VOL_PLAT_DIR=$BINARIES_DIR/volumio/platform-$PLAT
VOL_DIR=$VOL_PLAT_DIR/$MODEL
boardDir=`dirname $0 | while read a; do cd $a && pwd && break; done`

echo BINARIES_DIR $BINARIES_DIR
echo VOL_DIR $VOL_DIR

echo
echo Constructing Volumio requirements
echo

rm -rf $VOL_DIR
rm -f $BINARIES_DIR/$MODEL.tar.xz

# u-boot
mkdir -p $VOL_DIR/u-boot
cp $BINARIES_DIR/trust.img $VOL_DIR/u-boot/
cp $BINARIES_DIR/idbloader.img $VOL_DIR/u-boot/
cp $BINARIES_DIR/uboot.img $VOL_DIR/u-boot/uboot.img
#cp $BINARIES_DIR/boot.scr $VOL_DIR/u-boot/

#boot
mkdir -p $VOL_DIR/boot
cp $BINARIES_DIR/vars.txt $VOL_DIR/boot/
$MKIMAGE -C none -A arm -T script -d ${boardDir}/bootVolumio.cmd $BINARIES_DIR/bootVolumio.scr
cp $BINARIES_DIR/bootVolumio.scr $VOL_DIR/boot/boot.scr
cp ${boardDir}/varsVolumio.txt $VOL_DIR/boot/

# Linux
cp $BINARIES_DIR/Image $VOL_DIR/boot/
cp -a $BINARIES_DIR/rockchip $VOL_DIR/boot
# pushd $VOL_DIR/boot > /dev/null
# popd

pushd $LINUX_DIR > /dev/null
kver=`make kernelrelease`
popd
kver=$kver-`date +%Y.%d.%m-%H.%M`
cp $LINUX_DIR/.config $VOL_DIR/boot/config-${kver}
cp $LINUX_DIR/.config $VOL_DIR/config-${kver}

# modules and firmware
mkdir -p $VOL_DIR/lib
pushd $LINUX_DIR > /dev/null
make modules_install ARCH=arm64 INSTALL_MOD_PATH=$VOL_DIR
# # #make firmware_install ARCH=arm64 INSTALL_FW_PATH=$VOL_DIR/lib/firmware
popd
cp -a $BINARIES_DIR/../target/lib/firmware $VOL_DIR/lib

# patches
mkdir $VOL_DIR/patches
cp -a $boardDir/../../patches/linux/* $VOL_DIR/patches

echo creating tar.xz file
pushd $VOL_PLAT_DIR
tar cfJ $MODEL.tar.xz $MODEL
popd
mv $VOL_PLAT_DIR/$MODEL.tar.xz $BINARIES_DIR
echo $VOL_PLAT_DIR now exists
echo $MODEL.tar.xz located in the $BINARIES_DIR
