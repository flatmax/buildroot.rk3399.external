SMCLIB_VERSION = 1.8.3
SMCLIB_SITE = https://github.com/ros/bond_core/archive
SMCLIB_SOURCE = $(SMCLIB_VERSION).tar.gz
SMCLIB_SUBDIR = smclib

$(eval $(catkin-package))
