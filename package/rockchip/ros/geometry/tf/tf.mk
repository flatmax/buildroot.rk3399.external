TF_VERSION = 1.11.9

TF_SOURCE = $(TF_VERSION).tar.gz
TF_SITE = https://github.com/ros/geometry/archive
TF_SUBDIR = tf

TF_DEPENDENCIES = angles geometry-msgs message-filters message-generation \
		  rosconsole roscpp rostime sensor-msgs std-msgs tf2-ros

$(eval $(catkin-package))
