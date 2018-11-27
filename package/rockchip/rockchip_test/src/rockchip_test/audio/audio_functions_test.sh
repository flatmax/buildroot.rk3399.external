#!/bin/sh

echo ""
echo "*****************************************************"
echo "*        RK3308 Platform Audio Functions Test       *"
echo "*****************************************************"
echo "*  Loop playback:                              [0]  *"
echo "*  Loop capture:                               [1]  *"
echo "*  Exit audio test:                            [q]  *"
echo "*****************************************************"

echo ""
echo -n  "Please select a test case: "
read TEST_CASE
echo ""

PATH_AUDIO=/tmp/audio_test
mkdir -p $PATH_AUDIO

loop_playback()
{
	echo "******** Loop playback start ********"

	fs_tbl="8000 11025 16000 22050 32000 44100 48000 64000 88200 96000 176400 192000"
	bits_tbl="16 24 32"
	ch=2
	seconds=2
	gain=-30

	while [ $ch -ge 1 ]
	do
		for fs in $fs_tbl
        do
			for bits in $bits_tbl
			do
					# sox -b 16 -r 48000 -c 2 -n -t alsa hw:0,0 synth 2 sine 440 gain -18
					echo "ch="$ch", rate="$fs", bit=$bits, $seconds s, gain=$gain"
					sox -b $bits -r $fs -c $ch -n -t alsa hw:0,0 synth $seconds sine 440 gain $gain
			done
		done
	done

	echo "******** Loop playback end ********"
}

loop_capture()
{
	PATH_CAPTURE=$PATH_AUDIO/cap_files
	mkdir $PATH_CAPTURE

	fs_tbl="8000 11025 16000 22050 32000 44100 48000 64000 88200 96000 176400 192000"
	bits_tbl="S16_LE S24_LE S32_LE"
	ch_tbl="2 4 6 8"
	seconds=3

	echo "******** Loop capture start ********"

	for fs in $fs_tbl
	do
		for bits in $bits_tbl
		do
			for ch in $ch_tbl
			do
				DUMP_FILE=$(printf 'cap_fs%d_format_%s_ch%d.wav' $fs $bits $ch)
				echo "DUMP is $DUMP_FILE $seconds s"
				arecord -D hw:0,0 -r $fs -f $bits -c $ch -d $seconds $PATH_CAPTURE/$DUMP_FILE
			done
		done
	done

	echo "******** Loop capture end ********"

	echo "!! Please using 'adb pull /tmp/audio_test/cap_files/ .' dump all capture files !!"
}

case $TEST_CASE in
	"0")
		loop_playback
	;;
	"1")
		loop_capture
	;;
	"q")
		echo "Exit audio test"
	;;
	*)
		echo "Invalid case $TEST_CASE"
	;;
esac

exit
