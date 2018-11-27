#default to KINETIC
MESSAGE_FILTERS_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
MESSAGE_FILTERS_VERSION = 1.11.21
endif

MESSAGE_FILTERS_SITE = https://github.com/ros/ros_comm/archive
MESSAGE_FILTERS_SOURCE = $(MESSAGE_FILTERS_VERSION).tar.gz
MESSAGE_FILTERS_SUBDIR = utilities/message_filters

MESSAGE_FILTERS_DEPENDENCIES = boost rosconsole roscpp xmlrpcpp rostest

$(eval $(catkin-package))
