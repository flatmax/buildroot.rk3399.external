NODELET_CORE_VERSION = 1.9.14
NODELET_CORE_SITE = https://github.com/ros/nodelet_core/archive
NODELET_CORE_SOURCE = $(NODELET_CORE_VERSION).tar.gz
NODELET_CORE_SUBDIR = nodelet_core

$(eval $(catkin-package))
