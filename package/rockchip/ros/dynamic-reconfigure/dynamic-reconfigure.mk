DYNAMIC_RECONFIGURE_VERSION = 1.5.48
DYNAMIC_RECONFIGURE_SITE = https://github.com/ros/dynamic_reconfigure/archive
DYNAMIC_RECONFIGURE_SOURCE = $(DYNAMIC_RECONFIGURE_VERSION).tar.gz

DYNAMIC_RECONFIGURE_CONF_OPTS += -DCATKIN_ENABLE_TESTING=False
DYNAMIC_RECONFIGURE_DEPENDENCIES = roslib std-msgs roscpp rostest \
								   python-rospkg

$(eval $(catkin-package))

