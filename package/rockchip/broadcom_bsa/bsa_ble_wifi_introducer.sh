#!/bin/sh

hcd_file="BTFIRMWARE_PATH"
echo "hcd_file = $hcd_file"

case "$1" in
    start)

    echo 0 > /sys/class/rfkill/rfkill0/state
    sleep 3
    echo 1 > /sys/class/rfkill/rfkill0/state
    sleep 3

    mkdir -p /data/bsa/config
    cd /data/bsa/config
    echo "start broadcom bluetooth server bsa_sever"
    killall bsa_server

    bsa_server -r 12 -p $hcd_file -d /dev/ttyS4 -all=0 &
    sleep 2

    echo "start broadcom bluetooth app_manager"
    app_manager -s > /data/bsa/app_mananger.log &

    echo "start broadcom bluetooth wifi introducer"
    app_ble_wifi_introducer > /data/bsa/app_ble_wifi_introducer.log &
    sleep 1
    echo "|----- bluetooth ble wifi config ------|"

        ;;
    stop)
        echo "Stopping broadcom bsa bluetooth server & app"
        killall app_ble_wifi_introducer
        sleep 1
        killall app_manager
        sleep 1
        killall bsa_server
        sleep 2
        echo "|-----ble wifi config is close-----|"

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac

exit $?

