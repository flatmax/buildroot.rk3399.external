#default to KINETIC
ROSUNIT_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSUNIT_VERSION = 1.11.14
endif

ROSUNIT_SOURCE = $(ROSUNIT_VERSION).tar.gz
ROSUNIT_SITE = https://github.com/ros/ros/archive
ROSUNIT_SUBDIR = tools/rosunit

$(eval $(catkin-package))
