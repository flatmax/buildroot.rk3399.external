LIBUVC_CAMERA_VERSION = 0.0.9
LIBUVC_CAMERA_SITE = https://github.com/ros-drivers/libuvc_ros/archive
LIBUVC_CAMERA_SOURCE = $(LIBUVC_CAMERA_VERSION).tar.gz
LIBUVC_CAMERA_SUBDIR = libuvc_camera

LIBUVC_CAMERA_DEPENDENCIES = roscpp dynamic-reconfigure nodelet sensor-msgs camera-info-manager image-transport libuvc

define LIBUVC_CAMERA_FIX_PYTHON_BUILD
	$(SED) 's#python2#python#' \
		$(@D)/libuvc_camera/cfg/UVCCamera.cfg
endef
LIBUVC_CAMERA_POST_PATCH_HOOKS += LIBUVC_CAMERA_FIX_PYTHON_BUILD

$(eval $(catkin-package))
