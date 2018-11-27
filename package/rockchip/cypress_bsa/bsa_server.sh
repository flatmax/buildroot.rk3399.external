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
    bsa_server -r 12 -b /data/bsa/btsnoop.log -p $hcd_file -d /dev/ttyS4 > /data/bsa/bsa_log &
    sleep 2
    echo "|----- bluetooth bsa server is open ------|"

        ;;
    stop)
        echo "Stopping broadcom bsa bluetooth server"
        killall bsa_server
        sleep 2
        echo 0 > /sys/class/rfkill/rfkill0/state
        echo "|-----bluetooth bsa server is close-----|"

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac

exit $?

