GENEUS_VERSION = 2.2.6
GENEUS_SITE = https://github.com/jsk-ros-pkg/geneus/archive
GENEUS_SOURCE = $(GENEUS_VERSION).tar.gz
GENEUS_INSTALL_STAGING = YES

GENEUS_DEPENDENCIES = genmsg

$(eval $(catkin-package))
