GEOMETRY_VERSION = 1.11.9

GEOMETRY_SOURCE = $(GEOMETRY_VERSION).tar.gz
GEOMETRY_SITE = https://github.com/ros/geometry/archive
GEOMETRY_SUBDIR = geometry

$(eval $(catkin-package))
