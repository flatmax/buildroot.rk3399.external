#default to KINETIC
ROSMSG_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSMSG_VERSION = 1.11.21
endif

ROSMSG_SOURCE = $(ROSMSG_VERSION).tar.gz
ROSMSG_SITE = https://github.com/ros/ros_comm/archive
ROSMSG_SUBDIR = tools/rosmsg

$(eval $(catkin-package))
