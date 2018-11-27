STD_SRVS_VERSION = 1.11.2
STD_SRVS_SITE = https://github.com/ros/ros_comm_msgs/archive
STD_SRVS_SOURCE = $(STD_SRVS_VERSION).tar.gz
STD_SRVS_SUBDIR = std_srvs

$(eval $(catkin-package))
