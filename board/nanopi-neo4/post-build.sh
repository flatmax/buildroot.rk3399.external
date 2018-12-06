#!/bin/sh

BOARD_DIR="$(dirname $0)"

# copy over uboot files
UBOOT_BUILD_DIR=`find ${BUILD_DIR} -type d -name 'uboot-*'`
cp $UBOOT_BUILD_DIR/uboot.img ${BINARIES_DIR}/
cp $UBOOT_BUILD_DIR/trust.img ${BINARIES_DIR}/
cp $UBOOT_BUILD_DIR/rk3399_loader_v1.12.109.bin ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/MiniLoaderAll.bin

# copy over the kernel images
LINUX_BUILD_DIR=`find ${BUILD_DIR} -type d -name 'linux-nano*'`
cp $LINUX_BUILD_DIR/kernel.img ${BINARIES_DIR}/
cp $LINUX_BUILD_DIR/resource.img ${BINARIES_DIR}/
#cp $LINUX_BUILD_DIR/boot.img ${BINARIES_DIR}/
cp ${BOARD_DIR}/boot.img ${BINARIES_DIR}/

# setup the image creation software
cp ${BOARD_DIR}/parameter.txt ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/kernel.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/resource.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/boot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/uboot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/trust.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
ln -sf ${BINARIES_DIR}/rootfs.ext2 ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/rootfs.img

# create the sdcard image
${BINARIES_DIR}/sd-fuse-rk3399/mkimage.sh buildroot
mv ${BINARIES_DIR}/sd-fuse-rk3399/rk3399*.img /tmp
ln -sf /tmp/rk3399*.img ${BINARIES_DIR}/sdcard.img
echo run the following for a slow sdcard install :
echo dd if=${BINARIES_DIR}/sdcard.img of=/dev/sdxx buildroot

echo run the following for a quick sdcard install :
echo ${BINARIES_DIR}/sd-fuse-rk3399/fusing.sh /dev/sdxx buildroot

# echo "Creating the params.bin file"
# PARAMS_NAME=${BINARIES_DIR}/params.bin
# cp $UBOOT_BUILD_DIR/common/env_common.o /tmp
# ${HOST_DIR}/usr/bin/aarch64-linux-objcopy -O binary --only-section=.rodata.default_environment /tmp/env_common.o
# tr '\0' '\n' < /tmp/env_common.o | grep '=' > ${BINARIES_DIR}/default_envs.txt
# rm /tmp/env_common.o
# sed -i -e 's/bootcmd=run .*/bootcmd=run mmcboot/g' ${BINARIES_DIR}/default_envs.txt
# ${UBOOT_BUILD_DIR}/tools/mkenvimage -s 16384 -o $PARAMS_NAME ${BINARIES_DIR}/default_envs.txt

#wget https://raw.githubusercontent.com/rockchip-linux/device-custom/master/rk3399/parameter-buildroot.txt -O ${BINARIES_DIR}/parameter.txt

# BOARD_DIR="$(dirname $BOARD_DIR)/board"

#echo BOARD_DIR $BOARD_DIR
#cp ${BOARD_DIR}/idbloader.img ${BINARIES_DIR}/
#cp ${BOARD_DIR}/param4sd.txt ${BINARIES_DIR}/
return

# genimage doesn't work, use sd-fuse-rk3399 in the images directory
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"
