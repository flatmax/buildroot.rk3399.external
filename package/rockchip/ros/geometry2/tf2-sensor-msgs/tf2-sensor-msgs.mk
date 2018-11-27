TF2_SENSOR_MSGS_VERSION = 0.5.17

TF2_SENSOR_MSGS_SITE = https://github.com/ros/geometry2/archive
TF2_SENSOR_MSGS_SOURCE = $(TF2_SENSOR_MSGS_VERSION).tar.gz
TF2_SENSOR_MSGS_SUBDIR = tf2_sensor_msgs
TF2_SENSOR_MSGS_DEPENDENCIES = sensor-msgs cmake_modules tf2-ros boost

$(eval $(catkin-package))
