GENNODEJS_VERSION = 2.0.1
GENNODEJS_SITE = https://github.com/RethinkRobotics-opensource/gennodejs/archive
GENNODEJS_SOURCE = $(GENNODEJS_VERSION).tar.gz
GENNODEJS_INSTALL_STAGING = YES

GENNODEJS_DEPENDENCIES = genmsg

$(eval $(catkin-package))
