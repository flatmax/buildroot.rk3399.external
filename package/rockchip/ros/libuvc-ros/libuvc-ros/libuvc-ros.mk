LIBUVC_ROS_VERSION = 0.0.9
LIBUVC_ROS_SITE = https://github.com/ros-drivers/libuvc_ros/archive
LIBUVC_ROS_SOURCE = $(LIBUVC_ROS_VERSION).tar.gz
LIBUVC_ROS_SUBDIR = libuvc_ros

$(eval $(catkin-package))
