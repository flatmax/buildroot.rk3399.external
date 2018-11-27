#!/bin/sh

check_bsa_server() {
        while true;do
                pid=`pidof bsa_server`
                if [ "$pid" = "" ] ;then
                        echo "wait for bsa_server to start."
                        sleep 1
                fi
                        echo "bsa_server is open."
                        break
        done
}

case "$1" in
    start)
    check_bsa_server
    cd /data/bsa/config

    echo "start broadcom bluetooth app_avk"
    app_avk -s &
    echo "|----- bluetooth music player ------|"

        ;;
    stop)
        echo "Stopping broadcom bsa bluetooth app"
        killall app_avk
        check_not_exist.sh app_avk
        echo "|-----bluetooth music player is close-----|"

        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac

exit $?

