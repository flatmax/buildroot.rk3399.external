ACTIONLIB_MSGS_VERSION = 1.11.9
ACTIONLIB_MSGS_SOURCE = $(ACTIONLIB_MSGS_VERSION).tar.gz
ACTIONLIB_MSGS_SITE = https://github.com/ros/common_msgs/archive
ACTIONLIB_MSGS_SUBDIR = actionlib_msgs

ACTIONLIB_MSGS_DEPENDENCIES = \
	cpp_common roscpp_serialization \
	message-generation message-runtime std-msgs

$(eval $(catkin-package))
