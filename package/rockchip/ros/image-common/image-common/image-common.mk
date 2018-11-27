IMAGE_COMMON_VERSION = 1.11.11
IMAGE_COMMON_SITE = https://github.com/ros-perception/image_common/archive
IMAGE_COMMON_SOURCE = $(IMAGE_COMMON_VERSION).tar.gz
IMAGE_COMMON_SUBDIR = image_common

$(eval $(catkin-package))
