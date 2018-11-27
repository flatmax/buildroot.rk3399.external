TF2_GEOMETRY_MSGS_VERSION = 0.5.17

TF2_GEOMETRY_MSGS_SITE = https://github.com/ros/geometry2/archive
TF2_GEOMETRY_MSGS_SOURCE = $(TF2_GEOMETRY_MSGS_VERSION).tar.gz
TF2_GEOMETRY_MSGS_SUBDIR = tf2_geometry_msgs
TF2_GEOMETRY_MSGS_DEPENDENCIES = orocos-kdl tf2-ros

$(eval $(catkin-package))
