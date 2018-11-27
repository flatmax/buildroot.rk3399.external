#default to KINETIC
MK_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
MK_VERSION = 1.11.14
endif

MK_SOURCE = $(MK_VERSION).tar.gz
MK_SITE = https://github.com/ros/ros/archive
MK_SUBDIR = core/mk

$(eval $(catkin-package))
