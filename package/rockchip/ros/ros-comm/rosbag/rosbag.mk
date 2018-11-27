#default to KINETIC
ROSBAG_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSBAG_VERSION = 1.11.21
endif

ROSBAG_SOURCE = $(ROSBAG_VERSION).tar.gz
ROSBAG_SITE = https://github.com/ros/ros_comm/archive
ROSBAG_SUBDIR = tools/rosbag

ROSBAG_DEPENDENCIES = boost topic-tools rosbag-storage rosconsole

$(eval $(catkin-package))
