#default to KINETIC
ROSTOPIC_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSTOPIC_VERSION = 1.11.21
endif

ROSTOPIC_SOURCE = $(ROSTOPIC_VERSION).tar.gz
ROSTOPIC_SITE = https://github.com/ros/ros_comm/archive
ROSTOPIC_SUBDIR = tools/rostopic

ROSTOPIC_DEPENDENCIES = rostest

$(eval $(catkin-package))
