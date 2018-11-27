CAMERA_INFO_MANAGER_VERSION = 1.11.11
CAMERA_INFO_MANAGER_SITE = https://github.com/ros-perception/image_common/archive
CAMERA_INFO_MANAGER_SOURCE = $(CAMERA_INFO_MANAGER_VERSION).tar.gz
CAMERA_INFO_MANAGER_SUBDIR = camera_info_manager

CAMERA_INFO_MANAGER_DEPENDENCIES = boost camera-calibration-parsers image-transport roscpp roslib sensor-msgs rostest

define CAMERA_INFO_MANAGER_FIX_TINYXML2_DEPENDENCIES
	$(SED) 's#target_link_libraries($${PROJECT_NAME} $${catkin_LIBRARIES})#target_link_libraries($${PROJECT_NAME} $${catkin_LIBRARIES} -ltinyxml2)#' \
		$(@D)/camera_info_manager/CMakeLists.txt
	$(SED) 's#target_link_libraries(unit_test $${PROJECT_NAME} $${GTEST_LIBRARIES} $${catkin_LIBRARIES})#target_link_libraries(unit_test $${PROJECT_NAME} $${GTEST_LIBRARIES} $${catkin_LIBRARIES} -ltinyxml2)#' \
		$(@D)/camera_info_manager/CMakeLists.txt
endef
CAMERA_INFO_MANAGER_POST_PATCH_HOOKS += CAMERA_INFO_MANAGER_FIX_TINYXML2_DEPENDENCIES

$(eval $(catkin-package))
