TF2_MSGS_VERSION = 0.5.17

TF2_MSGS_SITE = https://github.com/ros/geometry2/archive
TF2_MSGS_SOURCE = $(TF2_MSGS_VERSION).tar.gz
TF2_MSGS_SUBDIR = tf2_msgs

TF2_MSGS_DEPENDENCIES = message-generation geometry-msgs actionlib-msgs boost

$(eval $(catkin-package))
