ROSGRAPH_MSGS_VERSION = 1.11.2
ROSGRAPH_MSGS_SITE = https://github.com/ros/ros_comm_msgs/archive
ROSGRAPH_MSGS_SOURCE = $(ROSGRAPH_MSGS_VERSION).tar.gz
ROSGRAPH_MSGS_SUBDIR = rosgraph_msgs

ROSGRAPH_MSGS_DEPENDENCIES = message-generation std-msgs

$(eval $(catkin-package))
