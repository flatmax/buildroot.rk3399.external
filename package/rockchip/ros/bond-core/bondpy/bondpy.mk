BONDPY_VERSION = 1.8.3
BONDPY_SITE = https://github.com/ros/bond_core/archive
BONDPY_SOURCE = $(BONDPY_VERSION).tar.gz
BONDPY_SUBDIR = bondpy

$(eval $(catkin-package))
