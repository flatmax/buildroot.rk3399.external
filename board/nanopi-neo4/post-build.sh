#!/bin/sh

echo $@

# copy uboot files required over :
UBOOT_BUILD_DIR=`find ${BUILD_DIR} -type d -name 'uboot-*'`
cp $UBOOT_BUILD_DIR/uboot.img ${BINARIES_DIR}/
cp $UBOOT_BUILD_DIR/trust.img ${BINARIES_DIR}/


BOARD_DIR="$(dirname $0)"
# BOARD_DIR="$(dirname $BOARD_DIR)/board"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

#echo BOARD_DIR $BOARD_DIR
cp ${BOARD_DIR}/idbloader.img ${BINARIES_DIR}/

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"
