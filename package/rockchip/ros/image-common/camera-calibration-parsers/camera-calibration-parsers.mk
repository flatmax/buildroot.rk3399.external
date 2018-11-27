CAMERA_CALIBRATION_PARSERS_VERSION = 1.11.11
CAMERA_CALIBRATION_PARSERS_SITE = https://github.com/ros-perception/image_common/archive
CAMERA_CALIBRATION_PARSERS_SOURCE = $(CAMERA_CALIBRATION_PARSERS_VERSION).tar.gz
CAMERA_CALIBRATION_PARSERS_SUBDIR = camera_calibration_parsers

CAMERA_CALIBRATION_PARSERS_DEPENDENCIES = boost yaml-cpp sensor-msgs rosconsole roscpp roscpp_serialization

$(eval $(catkin-package))
