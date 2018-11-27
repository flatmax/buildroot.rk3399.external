#default to KINETIC
ROSNODE_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSNODE_VERSION = 1.11.21
endif

ROSNODE_SOURCE = $(ROSNODE_VERSION).tar.gz
ROSNODE_SITE = https://github.com/ros/ros_comm/archive
ROSNODE_SUBDIR = tools/rosnode

ROSNODE_DEPENDENCIES = rostest

$(eval $(catkin-package))
