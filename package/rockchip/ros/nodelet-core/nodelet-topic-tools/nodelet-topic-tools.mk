NODELET_TOPIC_TOOLS_VERSION = 1.9.14
NODELET_TOPIC_TOOLS_SITE = https://github.com/ros/nodelet_core/archive
NODELET_TOPIC_TOOLS_SOURCE = $(NODELET_TOPIC_TOOLS_VERSION).tar.gz
NODELET_TOPIC_TOOLS_SUBDIR = nodelet_topic_tools
NODELET_TOPIC_TOOLS_DEPENDENCIES = boost dynamic-reconfigure

$(eval $(catkin-package))
