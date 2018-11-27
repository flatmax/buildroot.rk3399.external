#default to KINETIC
ROSCONSOLE_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSCONSOLE_VERSION = 1.11.21
endif

ROSCONSOLE_SOURCE = $(ROSCONSOLE_VERSION).tar.gz
ROSCONSOLE_SITE = https://github.com/ros/ros_comm/archive
ROSCONSOLE_SUBDIR = tools/rosconsole

ROSCONSOLE_DEPENDENCIES = \
	cpp_common rostime rosunit boost

$(eval $(catkin-package))
