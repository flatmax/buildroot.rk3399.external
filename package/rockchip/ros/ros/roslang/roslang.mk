#default to KINETIC
ROSLANG_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSLANG_VERSION = 1.11.14
endif

ROSLANG_SOURCE = $(ROSLANG_VERSION).tar.gz
ROSLANG_SITE = https://github.com/ros/ros/archive
ROSLANG_SUBDIR = core/roslang

$(eval $(catkin-package))
