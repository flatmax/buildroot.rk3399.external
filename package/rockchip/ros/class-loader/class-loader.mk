CLASS_LOADER_VERSION = 0.3.9
CLASS_LOADER_SITE = https://github.com/ros/class_loader/archive
CLASS_LOADER_SOURCE = $(CLASS_LOADER_VERSION).tar.gz
CLASS_LOADER_INSTALL_STAGING = YES

CLASS_LOADER_DEPENDENCIES = boost console-bridge cmake_modules poco

$(eval $(catkin-package))
