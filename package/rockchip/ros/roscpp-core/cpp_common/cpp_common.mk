#default to KINETIC
CPP_COMMON_VERSION = 0.6.11

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
CPP_COMMON_VERSION = 0.5.8
endif

CPP_COMMON_SITE = https://github.com/ros/roscpp_core/archive
CPP_COMMON_SOURCE = $(CPP_COMMON_VERSION).tar.gz
CPP_COMMON_SUBDIR = cpp_common
CPP_COMMON_DEPENDENCIES += console-bridge

$(eval $(catkin-package))
