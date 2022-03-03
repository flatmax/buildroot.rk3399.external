#!/usr/bin/env bash
cat >$1/RK3399TRUST.ini <<EOF
[VERSION]
MAJOR=1
MINOR=0
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=$2/bin/rk33/rk3399_bl31_v1.33.elf
ADDR=0x00040000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=$1/$3
EOF
$2/tools/trust_merger $1/RK3399TRUST.ini
# The following give kernel panic when running the command stress
# [BL32_OPTION]
# SEC=1
# PATH=$2/bin/rk33/rk3399_bl32_v1.22.bin
# ADDR=0x08400000
