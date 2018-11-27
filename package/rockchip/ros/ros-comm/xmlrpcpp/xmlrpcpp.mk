#default to KINETIC
XMLRPCPP_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
XMLRPCPP_VERSION = 1.11.21
endif

XMLRPCPP_SITE = https://github.com/ros/ros_comm/archive
XMLRPCPP_SOURCE = $(XMLRPCPP_VERSION).tar.gz
XMLRPCPP_SUBDIR = utilities/xmlrpcpp

XMLRPCPP_DEPENDENCIES = cpp_common rostime

$(eval $(catkin-package))
