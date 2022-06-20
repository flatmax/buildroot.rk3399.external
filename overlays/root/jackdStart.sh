#!/bin/sh
killall aplay
killall jackd
DIGIDEV=hw:CARD=test
#amixer -D$DIGIDEV set 'Port B source' 'loopback'

sleep 2
#jackd -P 95 -d alsa -r 96000 &
jackd -R -d alsa -r 96000 &
sleep 2
source ./jackdConnect.sh
