KDL_CONVERSIONS_VERSION = 1.11.9
KDL_CONVERSIONS_SOURCE = $(KDL_CONVERSIONS_VERSION).tar.gz
KDL_CONVERSIONS_SITE = https://github.com/ros/geometry/archive
KDL_CONVERSIONS_SUBDIR = kdl_conversions

KDL_CONVERSIONS_DEPENDENCIES = geometry-msgs orocos-kdl

$(eval $(catkin-package))
