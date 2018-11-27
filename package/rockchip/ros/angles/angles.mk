ANGLES_VERSION = 1.9.11

ANGLES_SOURCE = $(ANGLES_VERSION).tar.gz
ANGLES_SITE = https://github.com/ros/angles/archive
ANGLES_SUBDIR = angles

$(eval $(catkin-package))
