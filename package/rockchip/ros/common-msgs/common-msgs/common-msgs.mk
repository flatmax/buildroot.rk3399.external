COMMON_MSGS_VERSION = 1.11.9
COMMON_MSGS_SOURCE = $(COMMON_MSGS_VERSION).tar.gz
COMMON_MSGS_SITE = https://github.com/ros/common_msgs/archive
COMMON_MSGS_SUBDIR = common_msgs

$(eval $(catkin-package))
