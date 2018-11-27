BONDCPP_VERSION = 1.8.3
BONDCPP_SITE = https://github.com/ros/bond_core/archive
BONDCPP_SOURCE = $(BONDCPP_VERSION).tar.gz
BONDCPP_SUBDIR = bondcpp

BONDCPP_DEPENDENCIES = bond cmake_modules roscpp smclib util-linux

$(eval $(catkin-package))
