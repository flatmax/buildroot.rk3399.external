
#!/bin/sh

sensoropts='sensorname:,sensorbayer:,sensorexp:,sensorgain:,sensorres:'
mipiphyopts='mipiinfmt:,mipioutfmt:mipisdname:'
ispopts='ispinfmt:,ispincrop:,ispoutcrop:,ispoutfmt:'
pathopts='mpnode:,mpcrop:,mpfmt:,mpres:,spnode:,spcrop:,spfmt:,spres:'
allopts="medianode:,$mipiphyopts,$sensoropts,$ispopts,$pathopts"
ARGS=$(getopt -o h --long $allopts -- "$@")

#default parameters, could be retrieved by media-ctl and v4l2-ctl tools ?
medianode='0'
sensorname=''
sensorbayer=''
sensorexp=''
sensorgain=''
sensorres=''
mipiinfmt=''
mipioutfmt=''
mipisdname='rockchip-sy-mipi-dphy'
ispinfmt=''
ispincrop=''
ispoutcrop=''
ispoutfmt=''
ispsdname='rkisp1-isp-subdev'
mpnode=''
mpcrop=''
mpfmt='NV12'
mpres=''
spnode=''
spcrop=''
spfmt=''
spres=''

function parseSensorOpt
{
	case "$1" in
	--sensorname)
		sensorname="$2 $3"
		shift;
		echo "sensorname=\"$sensorname\""
		;;
	--sensorbayer)
		sensorbayer=$2
		echo "sensorbayer=$sensorbayer"
		;;
	--sensorexp)
		sensorexp=$2
		echo "sensorexp=$sensorexp"
		;;
	--sensorgain)
		sensorgain=$2
		echo "sensorgain=$sensorgain"
		;;
	--sensorres)
		sensorres=$2
		echo "sensorres=$sensorres"
		;;
	esac
}

function parseMipiOpt
{
	case "$1" in
	--mipiinfmt)
		mipiinfmt=$2
		echo "mipiinfmt=$mipiinfmt"
		;;
	--mipioutfmt)
		mipioutfmt=$2
		echo "mipioutfmt=$mipioutfmt"
		;;
	--mipisdname)
		mipisdname=$2
		echo "mipisdname=$mipisdname"
		;;
	esac
}

function parseISPOpt
{
	case "$1" in
	--ispinfmt)
		ispinfmt=$2
		echo "ispinfmt=$ispinfmt"
		;;
	--ispoutfmt)
		ispoutfmt=$2
		echo "ispoutfmt=$ispoutfmt"
		;;
	--ispincrop)
		ispincrop=$2
		echo "ispincrop=$ispincrop"
		;;
	--ispoutcrop)
		ispoutcrop=$2
		echo "ispoutcrop=$ispoutcrop"
		;;
	esac
}

function parseMpOpt
{
	case "$1" in
	--mpnode)
		mpnode=$2
		echo "mpnode=$mpnode"
		;;
	--mpcrop )
		mpcrop=$2
		echo "mpcrop=$mpcrop"
		;;
	--mpfmt)
		mpfmt=$2
		echo "mpfmt=$mpfmt"
		;;
	--mpres)
		mpres=$2
		echo "mpres=$mpres"
		;;
	esac
}

function parseSpOpt
{
	case "$1" in
	--spnode)
		spnode=$2
		echo "spnode=$spnode"
		;;
	--spcrop )
		spcrop=$2
		echo "mpcrop=$spcrop"
		;;
	--spfmt)
		spfmt=$2
		echo "spfmt=$spfmt"
		;;
	--spres)
		spres=$2
		echo "spres=$spres"
		;;
	esac
}

crop_temp_w=
crop_temp_h=
crop_temp_off_h=
crop_temp_off_v=
function calcCrop
{
	local full_w
	local full_h
	local target_w
	local target_h
	local ratio_full
	local ratio_target

	if [[ -z "$1"  ||  -z "$2" ]];then
		echo "error full res or target res is NULL !"
		exit 1
	fi

	full_w=${1%x*}
	full_h=${1#*x}
	target_w=${2%x*}
	target_h=${2#*x}
	let "ratio_full=full_w*100/full_h"
	let "ratio_target=target_w*100/target_h"

	if [[ $ratio_full -eq $ratio_target ]];then
		# echo "$ratio_full == $ratio_target"
		crop_temp_w=$full_w
		crop_temp_h=$full_h
	elif [[ $ratio_full -gt $ratio_target ]];then
		# echo "$ratio_full > $ratio_target"
		let "crop_temp_w=ratio_target*full_h/100"
		crop_temp_h=$full_h
	else
		# echo "$ratio_full < $ratio_target"
		crop_temp_w=$full_w
		let "crop_temp_h=full_w*100/ratio_target"
	fi
	let "crop_temp_w &=~1"
	let "crop_temp_h &=~1"
	let "crop_temp_off_h = (full_w - crop_temp_w) / 2"
	let "crop_temp_off_v = (full_h - crop_temp_h) / 2"

	echo "crop $crop_temp_w,$crop_temp_h@($crop_temp_off_h,$crop_temp_off_v)"
}

function help
{
cat << EOF
This script is based on media-ctl and v4l2-ctl which is used to configure
the media system formats, including sensor's output formats, exposure,
analogue gain and ISP subdev's input/output formats, crop and main/self
path format, crop.

usage: set_pipeline <--sensorname val> <--sensorbayer val> <--sensorres val> [options]
--h             show this message
--sensorname    sensor media entity name, could be retrieved by media-ctl.
                for example: 'ov5695 2-0036'
--sensorbayer   sensor output bayer format, could be: BG10,GB10,BA10,RG10
--sensorres     sensor output resolution, could be got from sensor driver.
                format is like: widthxheight
--medianode     optional, default is /dev/media0
--sensorexp     optional, sensor exposure, the value is configured to sensor
                directly
--sensorgain    optional, snesor analogue gain, the value is configured to sensor
                directly
--mipiinfmt     optional, mipi phy input format, default is the same as sensor
                output, couldn't be configured now
--mipioutfmt    optional, mipi phy input format, default is the same as mipi phy
                input format, couldn't be configured now
--mipisdname    optional, mipi phy subdev name, could be retrieved by media-ctl,
                default is: 'rockchip-sy-mipi-dphy'
--ispinfmt      optional, isp subdev input format, default is from mipioutfmt,
                couldn't be configured now
--ispincrop     optional, isp subdev input crop, default is no crop
                format is like: widthxheight, and only suppport center crop
--ispoutfmt     optional, isp subdev output format, defalut is:
                YUYV8_2X8/$ispincrop. it will be selected to output RAW if any
                value is set now.
--ispoutcrop    optional, isp subdev output crop, default is no crop
                format is like: widthxheight, and only suppport center crop
--mpnode        optional, mainpath video node
--mpcrop        optional, mainpath crop
                format is like: widthxheight, and only suppport center crop
--mpfmt         optional, the value type is FourCC, could be: NV12, NV21, NV16,
                NV61, NM12, YUYV, YU12, BG10, GB10, BA10, RG10
--mpres         optional, mainpath output resolution, format is like: widthxheight
--spnode        optional, selfpath video node
--spcrop        optional, selfpath crop
                format is like: widthxheight, and only suppport center crop
--spfmt         optional, the value type is FourCC, could be: NV12, NV21, NV16,
                NV61, NM12, YUYV, YU12
--spres         optional, selfpath output resolution, format is like: widthxheight

Eamples:
  MP outputs cropped and scaled NV12:
    set_pipeline.sh --sensorres 2592x1944 --sensorbayer BG10 --sensorname
    'ov5695 2-0036' --mpnode /dev/video0 --mpfmt NV12 --mpres 640x480
  MP outputs RAW
    set_pipeline.sh --sensorres 2592x1944 --sensorbayer BG10 --sensorname
	'ov5695 2-0036'  --ispoutfmt BG10 --mpnode /dev/video0 --mpfmt BG10 --mpcrop 2592x1944 --mpres
     2592x1944
EOF
}

# parse options
if [[ $? != 0  ]] ; then echo "unsupported parameters $@ ..." >&2 ; exit 1 ; fi
eval set --  "$ARGS"
while true;do
	case "$1" in
	--medianode)
		medianode=$2
		shift 2;;
	--sensorname | --sensorbayer | --sensorexp | --sensorgain | --sensorres)
		parseSensorOpt $1 $2
		shift 2;;
	--mipiinfmt| --mipioutfmt | --mipisdname)
		parseMipiOpt $1 $2
		shift 2;;
	--ispinfmt| --ispoutfmt | --ispincrop | --ispoutcrop)
		parseISPOpt $1 $2
		shift 2;;
	--mpnode| --mpcrop | --mpfmt | --mpres)
		parseMpOpt $1 $2
		shift 2;;
	--spnode| --spcrop | --spfmt | --spres)
		parseSpOpt $1 $2
		shift 2;;
	-h)
		help
		shift ;
		exit 0;;
	--)
		shift;
		break;;
	*)
		echo "unknown parameters $1"
		exit 1
		;;
	esac
done

echo "parse user options success ..."

# if we want to config sensor, all sensor infomation should be provided
if [[ -n "$sensorres" || -n "$sensorbayer" || -n "$sensorname" ]]; then
	if [[ -z "$sensorres"  ||  -z "$sensorbayer" || -z "$sensorname" ]];then
		echo "no sensor resolution or bayer or name !"
		exit 1
	fi
fi

sensorfmt=''
case "$sensorbayer" in
	"SBGGR10_1X10")
		sensorfmt='[fmt:SBGGR10/'$sensorres']'
		;;
	"SGBGR10_1X10")
		sensorfmt='[fmt:SGBGR10/'$sensorres']'
		;;
	"SRGGB10_1X10")
		sensorfmt='[fmt:SRGGB10/'$sensorres']'
		;;
	"SGRGB10_1X10")
		sensorfmt='[fmt:SGRGB10/'$sensorres']'
		;;
		'')
		;;
		*)
		echo "unknown sensor bayer $sensorbayer"
		exit 1
		;;
esac

if [[ -n "$sensorfmt" ]];then
	mipiinfmt=$sensorfmt
	mipioutfmt=$mipiinfmt
	ispinfmt=$mipioutfmt
	ispincrop=$sensorres
else
	if [[ -n "$ispinfmt" && -n "$ispincrop" ]];then
		case "$ispinfmt" in
			"BG10")
				ispinfmt='[fmt:SBGGR10/'$ispincrop']'
				;;
			"GB10")
				ispinfmt='[fmt:SGBGR10/'$ispincrop']'
				;;
			"RG10")
				ispinfmt='[fmt:SRGGB10/'$ispincrop']'
				;;
			"BA10")
				ispinfmt='[fmt:SGRGB10/'$ispincrop']'
				;;
				'')
				;;
				*)
				echo "unknown ispinfmt $ispinfmt"
				exit 1
				;;
		esac
	fi
fi

if [[ -z "$ispoutcrop" ]];then
	ispoutcrop=$ispincrop
fi

# TODO: why can't array type be defined ?
# rawfmt=("BG10" "GB10" "RG10" "BA10")
mpoutputraw=0
case "$mpfmt" in
	"BG10" | "GB10" | "RG10" | "BA10")
		mpoutputraw=1
		;;
	*)
		mpoutputraw=0
		;;
esac

ispoutputraw=0
# output yuv as default.
if [[ -z "$ispoutfmt" && -n "$ispoutcrop" ]];then
	ispoutfmt='[fmt:YUYV2X8/'$ispoutcrop']'
elif [[ -n "$ispoutfmt" && -n "$ispoutcrop" ]];then
	case "$ispoutfmt" in
		"BG10")
			ispoutfmt='[fmt:SBGGR10/'$ispoutcrop']'
			ispoutputraw=1
			;;
		"GB10")
			ispoutfmt='[fmt:SGBGR10/'$ispoutcrop']'
			ispoutputraw=1
			;;
		"RG10")
			ispoutfmt='[fmt:SRGGB10/'$ispoutcrop']'
			ispoutputraw=1
			;;
		"BA10")
			ispoutfmt='[fmt:SGRGB10/'$ispoutcrop']'
			ispoutputraw=1
			;;
			*)
			echo "unknown isp output fmt $ispoutfmt, set to default: YUYV8_2X8"
			ispoutfmt='[fmt:YUYV2X8/'$ispoutcrop']'
			;;
	esac
fi

if [[ -z "$mpcrop" ]];then
	mpcrop=$ispoutcrop
fi

if [[ -n "$mpnode"  &&  -n "$mpfmt"  &&  -n "$mpres" && -n "$mpcrop" ]];then
	# [[ ${rawfmt[@]/"$mpfmt"/} == ${rawfmt[@]} ]] && mpoutputraw=0 || mpoutputraw=1;
	if [[ $mpoutputraw -eq 1 && $ispoutputraw -eq 1 && $mpres != $mpcrop  ]];then
		echo "isp output RAW, but mp output resolution $mpres is not equal to crop $mpcrop !"
		exit 1
	elif [[ $mpoutputraw -eq 0 && $ispoutputraw -eq 1 ]];then
		echo "mp output YUV, but isp out RAW !"
		exit 1
	elif [[ $mpoutputraw -eq 1 && $ispoutputraw -eq 0 ]];then
		echo "mp output RAW, but isp out YUV !"
		exit 1
	fi
	calcCrop $mpcrop $mpres
	mpcrop='--set-selection=target=crop,'top'='$crop_temp_off_v,left'='$crop_temp_off_h,width'='$crop_temp_w,height'='$crop_temp_h
	# echo $mpcrop
	mpfmt='--set-fmt-video='width'='${mpres%x*},height'='${mpres#*x},pixelformat'='$mpfmt
	# echo $mpfmt
fi

if [[ -z "$spcrop" ]];then
	spcrop=$ispoutcrop
fi

if [[ -n "$spnode"  &&  -n "$spfmt"  &&  -n "$spres" && -n "$spcrop" ]];then
	if [[ $ispoutputraw == 1 ]];then
		echo "isp output RAW, sp can't receive !"
		exit 1
	fi
	if [[ ${spres%x*} -gt 1920 ]];then
		echo "sp output width can't exceed 1920 !"
		exit 1
	fi

	calcCrop $spcrop $spres
	spcrop='--set-selection=target=crop,'top'='$crop_temp_off_v,left'='$crop_temp_off_h,width'='$crop_temp_w,height'='$crop_temp_h
	# echo $spcrop
	spfmt='--set-fmt-video='width'='${mpres%x*},height'='${mpres#*x},pixelformat'='$spfmt
	# echo $spfmt
fi

# 1. set sensor
# notice that we should add "" quote for $sensorname
if [[ -n "$sensorfmt" ]];then
	fmtstr='"\"${sensorname}\"":0${sensorfmt}'
	# notice that we should add '' quote for fmtstr
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config sensor: \'${fmtstr}\'"
fi
# 2. set mipi_phy
if [[ -n "$mipisdname" && -n "$mipiinfmt" && -n "$mipioutfmt" ]];then
	fmtstr='"\"${mipisdname}\"":0${mipiinfmt}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config mipiphy input: \'${fmtstr}\'"
	fmtstr='"\"${mipisdname}\"":1${mipioutfmt}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config mipiphy output: \'${fmtstr}\'"
fi
#    has the same fmt with sensor
# 3. set isp subdev
#  3.1 input crop & fmt, normally we don't use the isp input crop, so just set
#  the size the same as the sensor output.

if [[ -n "$ispinfmt" && -n "$ispincrop" ]];then
	fmtstr='"\"${ispsdname}\"":0${ispinfmt}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config isp input fmt: \'${fmtstr}\'"
fi

if [[ -n "$ispincrop" ]];then
	ispincrop='[crop:('0,0')/'$ispincrop']'
	fmtstr='"\"${ispsdname}\"":0${ispincrop}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config isp input crop: \'${fmtstr}\'"
fi

#  3.2 output crop & fmt, normally we don't use the isp output crop, so just set
#  the size the same as the isp input crop.
if [[ -n "$ispoutcrop" ]];then
	ispoutcrop='[crop:('0,0')/'$ispoutcrop']'
	fmtstr='"\"${ispsdname}\"":2${ispoutcrop}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config isp output crop: \'${fmtstr}\'"
fi

if [[ -n "$ispoutfmt" && "$ispoutcrop" ]];then
	fmtstr='"\"${ispsdname}\"":2${ispoutfmt}'
	eval media-ctl -d /dev/media$medianode --set-v4l2 $(eval echo "\'${fmtstr}\'")
	eval echo "config isp output fmt: \'${fmtstr}\'"
fi

# 4. set main path
#  if only one path is needed and main path is satisfied, we use main path prior to self path.
if [[ -n "$mpcrop" && -n "$mpnode" ]];then
	v4l2-ctl -d $mpnode $mpcrop
	echo "config mp crop: $mpnode $mpcrop"
fi

if [[ -n "$mpfmt" && -n "$mpres" && -n "$mpnode" ]];then
	v4l2-ctl -d $mpnode $mpfmt
	echo "config mp fmt: $mpnode $mpfmt"
	if [[ -n "$sensorexp" ]];then
		v4l2-ctl -d $mpnode --set-ctrl $(eval echo "\'exposure=${sensorexp},analogue_gain=${sensorgain}\'")
		eval echo "config sensor exposure: \'exposure=${sensorexp}\'"
	fi
	# if [[ -n "$sensorgain" ]];then
	# 	v4l2-ctl -d $mpnode --set-ctrl $(eval echo "\'analogue_gain=${sensorgain}\'")
	# 	eval echo "config sensor again: \'analogue_gain=${sensorgain}\'"
	# fi
fi
# set sensor exposure & gain through main or self path video node, because these
# nodes inherit the sensor's controls. but there is a bug now , if two sensors
# are connected to the same ISP, we could only control the sensor 0.
#v4l2-ctl -d /dev/video4 --set-ctrl 'exposure=1216,analogue_gain=10'
# 5. set self path
if [[ -n "$spcrop" && -n "$spnode" ]];then
	v4l2-ctl -d $spnode $spcrop
	echo "config sp crop: $spnode $spcrop"
fi

if [[ -n "$spfmt" && -n "$spres" && -n "$spnode" ]];then
	v4l2-ctl -d $spnode $spfmt
	echo "config sp fmt: $spnode $spfmt"
	if [[ -n "$sensorexp" ]];then
		v4l2-ctl -d $mpnode --set-ctrl $(eval echo "\'exposure=${sensorexp}\'")
		eval echo "config sensor exposure: \'exposure=${sensorexp}\'"
	fi
	if [[ -n "$sensorgain" ]];then
		v4l2-ctl -d $mpnode --set-ctrl $(eval echo "\'analogue_gain=${sensorgain}\'")
		eval echo "config sensor again: \'analogue_gain=${sensorgain}\'"
	fi
fi
