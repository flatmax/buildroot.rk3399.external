SENSOR_MSGS_VERSION = 1.11.9
SENSOR_MSGS_SOURCE = $(SENSOR_MSGS_VERSION).tar.gz
SENSOR_MSGS_SITE = https://github.com/ros/common_msgs/archive
SENSOR_MSGS_SUBDIR = sensor_msgs

SENSOR_MSGS_DEPENDENCIES = geometry-msgs

$(eval $(catkin-package))
