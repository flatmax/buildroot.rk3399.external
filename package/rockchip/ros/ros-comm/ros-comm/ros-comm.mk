#default to KINETIC
ROS_COMM_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROS_COMM_VERSION = 1.11.21
endif

ROS_COMM_SOURCE = $(ROS_COMM_VERSION).tar.gz
ROS_COMM_SITE = https://github.com/ros/ros_comm/archive
ROS_COMM_SUBDIR = ros_comm

$(eval $(catkin-package))
