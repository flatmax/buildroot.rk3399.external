#default to KINETIC
ROSPARAM_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSPARAM_VERSION = 1.11.21
endif

ROSPARAM_SOURCE = $(ROSPARAM_VERSION).tar.gz
ROSPARAM_SITE = https://github.com/ros/ros_comm/archive
ROSPARAM_SUBDIR = tools/rosparam

$(eval $(catkin-package))
