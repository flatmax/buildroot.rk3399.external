DIAGNOSTIC_MSGS_VERSION = 1.11.9
DIAGNOSTIC_MSGS_SOURCE = $(DIAGNOSTIC_MSGS_VERSION).tar.gz
DIAGNOSTIC_MSGS_SITE = https://github.com/ros/common_msgs/archive
DIAGNOSTIC_MSGS_SUBDIR = diagnostic_msgs

$(eval $(catkin-package))
