#default to KINETIC
CV_BRIDGE_VERSION = 1.12.8
ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
CV_BRIDGE_VERSION = 1.11.16
endif

CV_BRIDGE_SITE = https://github.com/ros-perception/vision_opencv/archive
CV_BRIDGE_SOURCE = $(CV_BRIDGE_VERSION).tar.gz
CV_BRIDGE_SUBDIR = cv_bridge

CV_BRIDGE_DEPENDENCIES += boost rosconsole sensor-msgs host-python-numpy

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
CV_BRIDGE_DEPENDENCIES += opencv
endif

ifeq ($(BR2_PACKAGE_ROS_KINETIC),y)
CV_BRIDGE_DEPENDENCIES += opencv3
endif

$(eval $(catkin-package))
