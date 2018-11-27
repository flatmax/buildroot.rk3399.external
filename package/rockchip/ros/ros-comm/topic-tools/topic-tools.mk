#default to KINETIC
TOPIC_TOOLS_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
TOPIC_TOOLS_VERSION = 1.11.21
endif

TOPIC_TOOLS_SOURCE = $(TOPIC_TOOLS_VERSION).tar.gz
TOPIC_TOOLS_SITE = https://github.com/ros/ros_comm/archive
TOPIC_TOOLS_SUBDIR = tools/topic_tools

TOPIC_TOOLS_DEPENDENCIES = cpp_common message-generation rosconsole roscpp rostime std-msgs \
						   xmlrpcpp rostest

$(eval $(catkin-package))
