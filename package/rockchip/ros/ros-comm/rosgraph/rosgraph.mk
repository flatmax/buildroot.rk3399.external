#default to KINETIC
ROSGRAPH_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSGRAPH_VERSION = 1.11.21
endif

ROSGRAPH_SITE = https://github.com/ros/ros_comm/archive
ROSGRAPH_SOURCE = $(ROSGRAPH_VERSION).tar.gz
ROSGRAPH_SUBDIR = tools/rosgraph
ROSGRAPH_INSTALL_STAGING = YES

$(eval $(catkin-package))
