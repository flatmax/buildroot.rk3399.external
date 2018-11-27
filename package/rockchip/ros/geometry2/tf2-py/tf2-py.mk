TF2_PY_VERSION = 0.5.17

TF2_PY_SITE = https://github.com/ros/geometry2/archive
TF2_PY_SOURCE = $(TF2_PY_VERSION).tar.gz
TF2_PY_SUBDIR = tf2_py

TF2_PY_DEPENDENCIES = tf2 rospy

$(eval $(catkin-package))
