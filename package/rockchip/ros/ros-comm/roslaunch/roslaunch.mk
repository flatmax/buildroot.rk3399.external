#default to KINETIC
ROSLAUNCH_VERSION = 1.12.14
ROSLAUNCH_WORK_DIR = opt/ros/kinetic

ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
ROSLAUNCH_VERSION = 1.11.21
ROSLAUNCH_WORK_DIR = opt/ros/indigo
endif

ROSLAUNCH_SOURCE = $(ROSLAUNCH_VERSION).tar.gz
ROSLAUNCH_SITE = https://github.com/ros/ros_comm/archive
ROSLAUNCH_SUBDIR = tools/roslaunch

$(eval $(catkin-package))
