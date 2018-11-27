IMAGE_TRANSPORT_VERSION = 1.11.11
IMAGE_TRANSPORT_SITE = https://github.com/ros-perception/image_common/archive
IMAGE_TRANSPORT_SOURCE = $(IMAGE_TRANSPORT_VERSION).tar.gz
IMAGE_TRANSPORT_SUBDIR = image_transport

IMAGE_TRANSPORT_DEPENDENCIES = message-filters pluginlib rosconsole roscpp roslib sensor-msgs boost

define IMAGE_TRANSPORT_FIX_TINYXML2_DEPENDENCIES
	$(SED) 's#target_link_libraries(republish $${PROJECT_NAME})#target_link_libraries(republish $${PROJECT_NAME} -ltinyxml2)#' \
		$(@D)/image_transport/CMakeLists.txt

	$(SED) 's#target_link_libraries(list_transports#target_link_libraries(list_transports -ltinyxml2#' \
		$(@D)/image_transport/CMakeLists.txt
endef
IMAGE_TRANSPORT_POST_PATCH_HOOKS += IMAGE_TRANSPORT_FIX_TINYXML2_DEPENDENCIES

$(eval $(catkin-package))
