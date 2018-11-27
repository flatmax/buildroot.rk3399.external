#default to KINETIC
ROS_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROS_VERSION = 1.11.14
endif

ROS_SOURCE = $(ROS_VERSION).tar.gz
ROS_SITE = https://github.com/ros/ros/archive
ROS_SUBDIR = ros

$(eval $(catkin-package))
