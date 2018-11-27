TF2_ROS_VERSION = 0.5.17

TF2_ROS_SITE = https://github.com/ros/geometry2/archive
TF2_ROS_SOURCE = $(TF2_ROS_VERSION).tar.gz
TF2_ROS_SUBDIR = tf2_ros
TF2_ROS_DEPENDENCIES = actionlib actionlib-msgs geometry-msgs message-filters \
					   roscpp rosgraph rospy tf2 tf2-msgs tf2-py

$(eval $(catkin-package))
