#!/bin/sh

# BOARD_DIR="$(dirname $0)"

ubootName=`find $BASE_DIR/build -name 'uboot-*' -type d`
boardDir=`dirname $_`

RKBIN=$BINARIES_DIR/rkbin
RKTOOLS=$RKBIN/tools

# copy over uboot files
# UBOOT_BUILD_DIR=`find ${BUILD_DIR} -type d -name 'uboot-*'`
# cp $UBOOT_BUILD_DIR/uboot.img ${BINARIES_DIR}/
# cp $UBOOT_BUILD_DIR/trust.img ${BINARIES_DIR}/
#cp $UBOOT_BUILD_DIR/rk3399_loader_v1.12.109.bin ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/MiniLoaderAll.bin

# copy over the kernel images
LINUX_BUILD_DIR=`find ${BUILD_DIR} -type d -name 'linux-nano*'`
cp $LINUX_BUILD_DIR/kernel.img ${BINARIES_DIR}/
cp $LINUX_BUILD_DIR/resource.img ${BINARIES_DIR}/
#cp ${BOARD_DIR}/boot.img ${BINARIES_DIR}/

# setup the image creation software
# cp ${BOARD_DIR}/parameter.txt ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/kernel.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/resource.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/boot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/uboot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/trust.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
# ln -sf ${BINARIES_DIR}/rootfs.ext2 ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/rootfs.img

# create the sdcard image
# ${BINARIES_DIR}/sd-fuse-rk3399/mkimage.sh buildroot
# mv ${BINARIES_DIR}/sd-fuse-rk3399/rk3399*.img /tmp
# ln -sf /tmp/rk3399*.img ${BINARIES_DIR}/sdcard.img
# echo run the following for a slow sdcard install :
# echo dd if=${BINARIES_DIR}/sdcard.img of=/dev/sdxx buildroot

# echo run the following for a quick sdcard install :
# echo ${BINARIES_DIR}/sd-fuse-rk3399/fusing.sh /dev/sdxx buildroot

# Generate the uboot script
#$ubootName/tools/mkimage -C none -A arm -T script -d $BR2_EXTERNAL_RK3308_PATH/board/RK3308/boot.cmd $BINARIES_DIR/boot.scr

#make the first stage boot loader
#${boardDir}/mkRk3399Loader.bin.sh ${BINARIES_DIR} ${RKBIN} rk3399_loader_v1.24.124.bin
$ubootName/tools/mkimage -n rk3399 -T rksd -d ${RKBIN}/bin/rk33/rk3399_ddr_800MHz_v1.24.bin $BINARIES_DIR/idbloader.img
cat ${RKBIN}/bin/rk33/rk3399_miniloader_v1.24.bin >> $BINARIES_DIR/idbloader.img

# uboot creation
#$RKTOOLS/loaderimage --pack --uboot $ubootName/u-boot-dtb.bin $BINARIES_DIR/uboot.img 0x600000 --size 1024 1
$RKTOOLS/loaderimage --pack --uboot $ubootName/u-boot-dtb.bin $BINARIES_DIR/uboot.img

# Generate the uboot script
$ubootName/tools/mkimage -C none -A arm -T script -d ${boardDir}/boot.cmd $BINARIES_DIR/boot.scr
# copy uboot variable file over
cp -a ${boardDir}/vars.txt $BINARIES_DIR/

#make the trust image
${boardDir}/mkRk3399Trust.bin.sh ${BINARIES_DIR} ${RKBIN} trust.img

# copy overlays over
linuxDir=`find $BASE_DIR/build -name 'vmlinux' -type f | xargs dirname`
mkdir -p $BINARIES_DIR/rockchip/overlays
cp -a ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay/*.dtbo $BINARIES_DIR/rockchip/overlays
# Put the device trees into the correct location
cp -a ${linuxDir}/arch/arm64/boot/dts/rockchip/rk3399-nonopi-m4.dtb $BINARIES_DIR/rockchip

# Put the device trees into the correct location
# mkdir -p $BINARIES_DIR/rockchip; cp -a $BINARIES_DIR/*.dtb $BINARIES_DIR/rockchip
$BASE_DIR/../support/scripts/genimage.sh -c ${boardDir}/genimage.cfg

echo
echo
echo compilation done
echo
echo
echo
echo write your image to the sdcard, don\'t forget to change OF=/dev/sdg to your sdcard drive ...
echo use the following command ...
echo
echo 'OF=/dev/sdg; rootDrive=`mount | grep " / " | grep $OF`; if [ -z $rootDrive ]; then sudo umount $OF[123456789]; sudo dd if=output/images/sdcard.img of=$OF; else echo you are trying to overwrite your root drive; fi'
echo
echo
