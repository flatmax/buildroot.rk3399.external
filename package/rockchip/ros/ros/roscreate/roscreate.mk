#default to KINETIC
ROSCREATE_VERSION = 1.14.4

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSCREATE_VERSION = 1.11.14
endif

ROSCREATE_SOURCE = $(ROSCREATE_VERSION).tar.gz
ROSCREATE_SITE = https://github.com/ros/ros/archive
ROSCREATE_SUBDIR = tools/roscreate

$(eval $(catkin-package))
