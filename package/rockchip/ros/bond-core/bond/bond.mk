BOND_VERSION = 1.8.3
BOND_SITE = https://github.com/ros/bond_core/archive
BOND_SOURCE = $(BOND_VERSION).tar.gz
BOND_SUBDIR = bond

BOND_DEPENDENCIES = message-generation std-msgs

$(eval $(catkin-package))
