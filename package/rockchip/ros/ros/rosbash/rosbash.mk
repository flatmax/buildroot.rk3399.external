#default to KINETIC
ROSBASH_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSBASH_VERSION = 1.11.14
endif

ROSBASH_SOURCE = $(ROSBASH_VERSION).tar.gz
ROSBASH_SITE = https://github.com/ros/ros/archive
ROSBASH_SUBDIR = tools/rosbash

ROSBASH_DEPENDENCIES = bash findutils

$(eval $(catkin-package))
