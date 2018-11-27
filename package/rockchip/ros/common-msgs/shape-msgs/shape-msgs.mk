SHAPE_MSGS_VERSION = 1.11.9
SHAPE_MSGS_SOURCE = $(SHAPE_MSGS_VERSION).tar.gz
SHAPE_MSGS_SITE = https://github.com/ros/common_msgs/archive
SHAPE_MSGS_SUBDIR = shape_msgs

SHAPE_MSGS_DEPENDENCIES = geometry-msgs

$(eval $(catkin-package))
