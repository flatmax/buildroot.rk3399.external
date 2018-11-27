#default to KINETIC
ROSOUT_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSOUT_VERSION = 1.11.21
endif

ROSOUT_SOURCE = $(ROSOUT_VERSION).tar.gz
ROSOUT_SITE = https://github.com/ros/ros_comm/archive
ROSOUT_SUBDIR = tools/rosout

ROSOUT_DEPENDENCIES = roscpp rosgraph_msgs

$(eval $(catkin-package))
