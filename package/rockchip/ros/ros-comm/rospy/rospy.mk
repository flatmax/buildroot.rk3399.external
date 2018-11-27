#default to KINETIC
ROSPY_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSPY_VERSION = 1.11.21
endif

ROSPY_SITE = https://github.com/ros/ros_comm/archive
ROSPY_SOURCE = $(ROSPY_VERSION).tar.gz
ROSPY_SUBDIR = clients/rospy

ROSPY_DEPENDENCIES = std-msgs genpy rosgraph roslib rosgraph_msgs roscpp \
					 python-pyyaml

$(eval $(catkin-package))
