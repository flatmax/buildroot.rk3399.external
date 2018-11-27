TRAJECTORY_MSGS_VERSION = 1.11.9
TRAJECTORY_MSGS_SOURCE = $(TRAJECTORY_MSGS_VERSION).tar.gz
TRAJECTORY_MSGS_SITE = https://github.com/ros/common_msgs/archive
TRAJECTORY_MSGS_SUBDIR = trajectory_msgs

TRAJECTORY_MSGS_DEPENDENCIES = geometry-msgs

$(eval $(catkin-package))
