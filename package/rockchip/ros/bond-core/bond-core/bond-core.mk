BOND_CORE_VERSION = 1.8.3
BOND_CORE_SITE = https://github.com/ros/bond_core/archive
BOND_CORE_SOURCE = $(BOND_CORE_VERSION).tar.gz
BOND_CORE_SUBDIR = bond_core

$(eval $(catkin-package))
