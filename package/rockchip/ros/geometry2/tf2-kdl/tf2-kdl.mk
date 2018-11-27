TF2_KDL_VERSION = 0.5.17

TF2_KDL_SITE = https://github.com/ros/geometry2/archive
TF2_KDL_SOURCE = $(TF2_KDL_VERSION).tar.gz
TF2_KDL_SUBDIR = tf2_kdl
TF2_KDL_DEPENDENCIES = orocos-kdl tf2-ros

$(eval $(catkin-package))
