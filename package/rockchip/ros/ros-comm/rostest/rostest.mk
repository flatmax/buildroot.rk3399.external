#default to KINETIC
ROSTEST_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSTEST_VERSION = 1.11.21
endif

ROSTEST_SITE = https://github.com/ros/ros_comm/archive
ROSTEST_SOURCE = $(ROSTEST_VERSION).tar.gz
ROSTEST_SUBDIR = tools/rostest

ROSTEST_DEPENDENCIES = rosunit boost

$(eval $(catkin-package))
