#default to KINETIC
ROSSERVICE_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSSERVICE_VERSION = 1.11.21
endif

ROSSERVICE_SOURCE = $(ROSSERVICE_VERSION).tar.gz
ROSSERVICE_SITE = https://github.com/ros/ros_comm/archive
ROSSERVICE_SUBDIR = tools/rosservice

$(eval $(catkin-package))
