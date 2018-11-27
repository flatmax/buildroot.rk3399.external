#default to KINETIC
ROSCPP_VERSION = 1.12.14

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSCPP_VERSION = 1.11.21
endif

ROSCPP_SOURCE = $(ROSCPP_VERSION).tar.gz
ROSCPP_SITE = https://github.com/ros/ros_comm/archive
ROSCPP_SUBDIR = clients/roscpp

ROSCPP_DEPENDENCIES = cpp_common message-generation \
		      rosconsole roscpp_serialization roscpp_traits \
		      rosgraph_msgs rostime std-msgs xmlrpcpp boost

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
define ROSCPP_INDIGO_PATCH
	$(APPLY_PATCHES) $(@D) $(PKGDIR)/file
endef
ROSCPP_POST_PATCH_HOOKS += ROSCPP_INDIGO_PATCH
endif

$(eval $(catkin-package))
