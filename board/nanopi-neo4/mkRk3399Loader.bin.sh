#!/usr/bin/env bash
cat >$1/RK3399MINIALL.ini <<EOF
[CHIP_NAME]
NAME=RK330C
[VERSION]
MAJOR=1
MINOR=24
[CODE471_OPTION]
NUM=1
Path1=$2/bin/rk33/rk3399_ddr_800MHz_v1.24.bin
Sleep=1
[CODE472_OPTION]
NUM=1
Path1=$2/bin/rk33/rk3399_usbplug_v1.24.bin
[LOADER_OPTION]
NUM=2
LOADER1=FlashData
LOADER2=FlashBoot
FlashData=$2/bin/rk33/rk3399_ddr_800MHz_v1.24.bin
FlashBoot=$2/bin/rk33/rk3399_miniloader_v1.24.bin
[OUTPUT]
PATH=$1/$3
EOF
$2/tools/boot_merger $1/RK3399MINIALL.ini
