STD_MSGS_VERSION = 0.5.10
STD_MSGS_SITE = https://github.com/ros/std_msgs/archive
STD_MSGS_SOURCE = $(STD_MSGS_VERSION).tar.gz

STD_MSGS_DEPENDENCIES = message-generation message-runtime

ifeq ($(BR2_PACKAGE_ROS_KINETIC),y)
STD_MSGS_DEPENDENCIES += host-python-pyyaml
endif

$(eval $(catkin-package))

