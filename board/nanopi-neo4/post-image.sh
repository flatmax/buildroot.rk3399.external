#!/bin/sh

# BOARD_DIR="$(dirname $0)"
ubootName=`find $BASE_DIR/build -name 'uboot-*' -type d`
boardDir=`dirname $_`

RKBIN=$BINARIES_DIR/rkbin
RKTOOLS=$RKBIN/tools

#make the first stage boot loader
$ubootName/tools/mkimage -n rk3399 -T rksd -d ${RKBIN}/bin/rk33/rk3399_ddr_800MHz_v1.24.bin $BINARIES_DIR/idbloader.img
cat ${RKBIN}/bin/rk33/rk3399_miniloader_v1.24.bin >> $BINARIES_DIR/idbloader.img

# uboot creation
$RKTOOLS/loaderimage --pack --uboot $ubootName/u-boot-dtb.bin $BINARIES_DIR/uboot.img

# Generate the uboot script
$ubootName/tools/mkimage -C none -A arm -T script -d ${boardDir}/boot.cmd $BINARIES_DIR/boot.scr
# alter the vars.txt file
dtbName=`grep BR2_LINUX_KERNEL_INTREE_DTS_NAME $BR2_CONFIG | sed 's/^.*=//;s/"//g'`
sed -i "s|.*fdt_name.*|fdt_name=$dtbName.dtb|" ${boardDir}/vars.txt
# copy uboot variable file over
cp -a ${boardDir}/vars.txt $BINARIES_DIR/
#make the trust image
${boardDir}/mkRk3399Trust.bin.sh ${BINARIES_DIR} ${RKBIN} trust.img

# copy the device tree and overlays over
linuxDir=`find $BASE_DIR/build -name 'vmlinux' -type f | xargs dirname`
if [ ! -d $BINARIES_DIR/rockchip/overlays ]; then
  mkdir -p $BINARIES_DIR/rockchip/overlays
fi
if [ -d ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay ]; then
  cp -a ${linuxDir}/arch/arm64/boot/dts/rockchip/overlay/*.dtbo $BINARIES_DIR/rockchip/overlays
fi
cp -a ${linuxDir}/arch/arm64/boot/dts/${dtbName}.dtb $BINARIES_DIR/rockchip

# generate the image
$BASE_DIR/../support/scripts/genimage.sh -c ${boardDir}/genimage.cfg

echo
echo
echo compilation done
echo
echo
echo
echo write your image to the sdcard, don\'t forget to change OF=/dev/sdb to your sdcard drive ...
echo use the following command ...
echo
echo 'OF=/dev/sdb; rootDrive=`mount | grep " / " | grep $OF`; if [ -z $rootDrive ]; then sudo umount $OF[123456789]; sudo dd if=output/images/sdcard.img of=$OF; else echo you are trying to overwrite your root drive; fi'
echo
echo

echo
echo generating the volumio post image binaries.
echo
# generate Volumio requirements
${boardDir}/mkRk3399Volumio.bin.sh ${BINARIES_DIR} rk3399 $linuxDir nanopim4 $ubootName/tools/mkimage
