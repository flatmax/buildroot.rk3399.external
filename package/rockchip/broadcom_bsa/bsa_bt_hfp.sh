#!/bin/sh

hcd_file="BTFIRMWARE_PATH"
echo "hcd_file = $hcd_file"

case "$1" in
    start)

    echo 0 > /sys/class/rfkill/rfkill0/state
    sleep 1
    echo 1 > /sys/class/rfkill/rfkill0/state
    sleep 1

    mkdir -p /data/bsa/config
    cd /data/bsa/config
    echo "start broadcom bluetooth bsa_sever"
    killall bsa_server
    bsa_server -r 13 -p $hcd_file -d /dev/ttyS4 -all=0 &
    sleep 2

    echo "start broadcom bluetooth app_manager"
    app_manager -s &

    echo "start broadcom bluetooth app_hs"
    app_hs &
    sleep 1

    echo "|----- bluetooth hfp is start------|"

        ;;
    stop)
        echo "Stopping broadcom bsa bluetooth server & app"
        killall app_hs
        sleep 1
        killall app_manager
        sleep 1
        killall bsa_server
        sleep 2
        echo "|-----bluetooth hfp is close-----|"

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac

exit $?
