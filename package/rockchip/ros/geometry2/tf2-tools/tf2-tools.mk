TF2_TOOLS_VERSION = 0.5.17

TF2_TOOLS_SITE = https://github.com/ros/geometry2/archive
TF2_TOOLS_SOURCE = $(TF2_TOOLS_VERSION).tar.gz
TF2_TOOLS_SUBDIR = tf2_tools

TF2_TOOLS_DEPENDENCIES = tf2-ros

$(eval $(catkin-package))
