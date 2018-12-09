#! /bin/bash
# Author : Matt Flax <flatmax@flatmax.org>
# Date : Nov 2018

if [ $# -lt 1 ]; then
  echo usage :
  me=`basename "$0"`
  echo "     " $me path.to.buildroot.neo4
  echo for example :
  echo "     " $me /home/flatmax.unencrypted/buildroot.rockchip
else
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

  CUSTOM_PATH=$DIR
  BR_REPO_PATH=$1
  BR_DEFCONFIG=neo4_defconfig
  BR_CUSTOM_DEFCONFIG=neo4_custom_defconfig

    if [ ! -d "$BR_REPO_PATH" ]; then
    	echo Can\'t find the directory $BR_REPO_PATH please correct the bash script.
    	return;
    fi
    if [ ! -d "$CUSTOM_PATH" ]; then
    	echo Can\'t find the directory $CUSTOM_PATH please correct the bash script.
    	return;
    fi

    if [ ! -e $CUSTOM_PATH/configs/$BR_CUSTOM_DEFCONFIG ]; then
    	echo can\'t find the file $CUSTOM_PATH/configs/$BR_CUSTOM_DEFCONFIG
    	echo please fix this script
    	return;
    fi

    # remove libdrm so that we use the rockchip version
    if [ -d "$BR_REPO_PATH/package/libdrm" ]; then
      pushd $BR_REPO_PATH/package
      tar zcpf libdrm.tgz libdrm
      sed -i '/libdrm/d' Config.in
      popd
      rm -rf $BR_REPO_PATH/package/libdrm
    fi
    if [ -d "$BR_REPO_PATH/package/weston" ]; then
      pushd $BR_REPO_PATH/package
      tar zcpf weston.tgz weston
      sed -i '/weston/d' Config.in
      popd
      rm -rf $BR_REPO_PATH/package/weston
    fi
    if [ -d "$BR_REPO_PATH/package/mesa3d" ]; then
      pushd $BR_REPO_PATH/package
      tar zcpf mesa3d.tgz mesa3d
      sed -i '/mesa3d/d' Config.in
      popd
      rm -rf $BR_REPO_PATH/package/mesa3d
    fi
    if [ -d "$BR_REPO_PATH/package/mesa3d-headers" ]; then
      pushd $BR_REPO_PATH/package
      tar zcpf mesa3d-headers.tgz mesa3d-headers
      sed -i '/mesa3d-headers/d' Config.in
      popd
      rm -rf $BR_REPO_PATH/package/mesa3d-headers
    fi

    cd $1

    # uncomment these to include them ...
    cat $CUSTOM_PATH/configs/rockchip/rk3399_arm64.config > $CUSTOM_PATH/configs/$BR_DEFCONFIG
    cat $CUSTOM_PATH/configs/rockchip/base.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    cat $CUSTOM_PATH/configs/rockchip/base_extra.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    cat $CUSTOM_PATH/configs/rockchip/gpu.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    cat $CUSTOM_PATH/configs/rockchip/video_mpp.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    #cat $CUSTOM_PATH/configs/rockchip/video_gst.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/audio.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/camera.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/camera_gst.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/test.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/debug.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/benchmark.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/wifi.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/bt.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/qt.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG
    # cat $CUSTOM_PATH/configs/rockchip/qt_app.config >> $CUSTOM_PATH/configs/$BR_DEFCONFIG

    cat $CUSTOM_PATH/configs/$BR_CUSTOM_DEFCONFIG >> $CUSTOM_PATH/configs/$BR_DEFCONFIG

    make BR2_EXTERNAL=$CUSTOM_PATH $BR_DEFCONFIG
fi
