#default to KINETIC
ROSTIME_VERSION = 0.6.11

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSTIME_VERSION = 0.5.8
endif

ROSTIME_SITE = https://github.com/ros/roscpp_core/archive
ROSTIME_SOURCE = $(ROSTIME_VERSION).tar.gz
ROSTIME_SUBDIR = rostime
ROSTIME_DEPENDENCIES += boost cpp_common

$(eval $(catkin-package))
