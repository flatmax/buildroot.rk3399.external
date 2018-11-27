PLUGINLIB_VERSION = 1.11.3
ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
PLUGINLIB_VERSION = 1.10.6
endif

PLUGINLIB_SOURCE = $(PLUGINLIB_VERSION).tar.gz
PLUGINLIB_SITE = https://github.com/ros/pluginlib/archive

PLUGINLIB_DEPENDENCIES = boost class-loader rosconsole roslib tinyxml

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
PLUGINLIB_DEPENDENCIES += tinyxml
endif

ifeq ($(BR2_PACKAGE_ROS_KINETIC),y)
PLUGINLIB_DEPENDENCIES += tinyxml2
define PLUGINLIB_KINETIC_PATCH
	$(SED) 's%find_package(TinyXML2%find_package(tinyxml2%' $(@D)/CMakeLists.txt
endef
PLUGINLIB_POST_PATCH_HOOKS += PLUGINLIB_KINETIC_PATCH
endif


$(eval $(catkin-package))
