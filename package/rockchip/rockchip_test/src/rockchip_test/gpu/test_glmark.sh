#!/bin/bash -e

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
function set_performance() {
if [ "$1" == "rk3288" ];
then
	echo performance > /sys/class/devfreq/dmc/governor # set ddr
	echo performance > /sys/class/devfreq/ffa30000.gpu/governor # set gpu
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor # set lit cpu
	echo "set the cpu/ddr/gpu for performance"

elif [[  "$1" == "rk3328"  ]]; then
	echo performance > /sys/class/devfreq/dmc/governor # set ddr
	echo performance > /sys/class/devfreq/ff300000.gpu/governor # set gpu
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor # set lit cpu
	echo "set the cpu/ddr/gpu for performance"

elif [[  "$1" == "rk3399"  ]]; then
	echo performance > /sys/class/devfreq/dmc/governor # set ddr
	echo performance > /sys/class/devfreq/ff9a0000.gpu/governor # set gpu
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor # set lit cpu
	echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor # set big cpu
	echo "set the cpu/ddr/gpu for performance"

elif [[  "$1" == "px30" || "$1" == "rk3326"  ]]; then
	echo performance > /sys/class/devfreq/dmc/governor # set ddr
	echo performance > /sys/class/devfreq/ff400000.gpu/governor # set gpu
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor # set lit cpu
	echo "set the cpu/ddr/gpu for performance"

elif [[  "$1" == "rk1808" || "$1" == "rk3308"  ]]; then
	echo "the chips didn't support gpu"

elif [[  "$1" == "px3se"  ]]; then
	echo performance > /sys/class/devfreq/dmc/governor # set ddr
	echo performance > /sys/class/devfreq/10091000.gpu/governor # set gpu
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor # set lit cpu
	echo "set the cpu/ddr/gpu for performance"
else
	echo "please check if the linux support it!!!!!!!"
fi
}

COMPATIBLE=$(cat /proc/device-tree/compatible)
if [[ $COMPATIBLE =~ "rk3288" ]];
then
    CHIPNAME="rk3288"
elif [[ $COMPATIBLE =~ "rk3308" ]]; then
    CHIPNAME="rk3308"
elif [[ $COMPATIBLE =~ "rk3328" ]]; then
    CHIPNAME="rk3328"
elif [[ $COMPATIBLE =~ "rk3399" ]]; then
    CHIPNAME="rk3399"
elif [[ $COMPATIBLE =~ "rk3326" ]]; then
    CHIPNAME="rk3326"
elif [[ $COMPATIBLE =~ "rk3399" ]]; then
    CHIPNAME="rk3399"
elif [[ $COMPATIBLE =~ "rk1808" ]]; then
    CHIPNAME="rk1808"
elif [[ $COMPATIBLE =~ "px3se" ]]; then
    CHIPNAME="px3se"
else
    CHIPNAME="rk3399"
fi
COMPATIBLE=${COMPATIBLE#rockchip,}

set_performance ${CHIPNAME}

export XDG_RUNTIME_DIR=/tmp/.xdg
glmark2-es2-wayland --fullscreen

echo "the governor is performance for now, please restart it........"
