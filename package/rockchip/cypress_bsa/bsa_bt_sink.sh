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
    echo "start broadcom bluetooth server bsa_sever"
    killall bsa_server
    #bsa_server -r 12 -b /data/bsa/btsnoop.log -p $hcd_file -d /dev/ttyS4 > /data/bsa/bsa_log &
     bsa_server -r 12 -p $hcd_file -d /dev/ttyS4 -all=0 &
    sleep 2

    echo "start broadcom bluetooth app_manager"
    #app_manager -s > /data/bsa/app_mananger.log &
    app_manager -s &
    
    echo "start broadcom bluetooth app_avk"
    #app_avk -s > /data/bsa/app_avk.log &
    app_avk -s &
    sleep 3

    echo "#########act as a bluetooth music player#########"
    app_socket avk 2
    sleep 2
    echo "|----- bluetooth music player ------|"

        ;;
    stop)
        echo "Stopping broadcom bsa bluetooth server & app"
        killall app_socket
        sleep 1
        killall app_avk
        sleep 1
        killall app_manager
        sleep 1
        killall bsa_server
        sleep 2
        echo "|-----bluetooth music player is close-----|"

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac

exit $?

