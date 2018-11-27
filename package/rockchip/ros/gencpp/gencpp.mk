GENCPP_VERSION = 0.5.5
GENCPP_SITE = https://github.com/ros/gencpp/archive
GENCPP_SOURCE = $(GENCPP_VERSION).tar.gz
GENCPP_INSTALL_STAGING = YES

GENCPP_DEPENDENCIES = genmsg

$(eval $(catkin-package))
