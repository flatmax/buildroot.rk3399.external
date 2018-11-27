GEOMETRY_MSGS_VERSION = 1.11.9
GEOMETRY_MSGS_SOURCE = $(GEOMETRY_MSGS_VERSION).tar.gz
GEOMETRY_MSGS_SITE = https://github.com/ros/common_msgs/archive
GEOMETRY_MSGS_SUBDIR = geometry_msgs

$(eval $(catkin-package))
