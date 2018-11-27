#default to KINETIC
ROSWTF_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSWTF_VERSION = 1.11.21
endif

ROSWTF_SOURCE = $(ROSWTF_VERSION).tar.gz
ROSWTF_SITE = https://github.com/ros/ros_comm/archive
ROSWTF_SUBDIR = utilities/roswtf

ROSWTF_DEPENDENCIES = rostest

$(eval $(catkin-package))
