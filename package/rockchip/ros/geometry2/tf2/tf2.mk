TF2_VERSION = 0.5.17

TF2_SITE = https://github.com/ros/geometry2/archive
TF2_SOURCE = $(TF2_VERSION).tar.gz
TF2_SUBDIR = tf2
TF2_DEPENDENCIES = geometry-msgs tf2-msgs boost rostime console-bridge gtest

$(eval $(catkin-package))
