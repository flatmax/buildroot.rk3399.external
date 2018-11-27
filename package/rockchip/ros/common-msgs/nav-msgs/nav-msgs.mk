NAV_MSGS_VERSION = 1.11.9
NAV_MSGS_SOURCE = $(NAV_MSGS_VERSION).tar.gz
NAV_MSGS_SITE = https://github.com/ros/common_msgs/archive
NAV_MSGS_SUBDIR = nav_msgs

NAV_MSGS_DEPENDENCIES = actionlib-msgs geometry-msgs

$(eval $(catkin-package))
