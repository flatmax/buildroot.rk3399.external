STEREO_MSGS_VERSION = 1.11.9
STEREO_MSGS_SOURCE = $(STEREO_MSGS_VERSION).tar.gz
STEREO_MSGS_SITE = https://github.com/ros/common_msgs/archive
STEREO_MSGS_SUBDIR = stereo_msgs

STEREO_MSGS_DEPENDENCIES = sensor-msgs

$(eval $(catkin-package))
