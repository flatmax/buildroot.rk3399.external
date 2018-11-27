NODELET_VERSION = 1.9.14
NODELET_SITE = https://github.com/ros/nodelet_core/archive
NODELET_SOURCE = $(NODELET_VERSION).tar.gz
NODELET_SUBDIR = nodelet
NODELET_DEPENDENCIES = bondcpp cmake_modules message-generation pluginlib rosconsole \
		       roscpp std-msgs

define NODELET_FIX_TINYXML2_DEPENDENCIES
	$(SED) 's#target_link_libraries(nodeletlib $${catkin_LIBRARIES} $${BOOST_LIBRARIES})#target_link_libraries(nodeletlib $${catkin_LIBRARIES} $${BOOST_LIBRARIES} -ltinyxml2)#' \
		$(@D)/nodelet/CMakeLists.txt
endef
NODELET_POST_PATCH_HOOKS += NODELET_FIX_TINYXML2_DEPENDENCIES

$(eval $(catkin-package))
