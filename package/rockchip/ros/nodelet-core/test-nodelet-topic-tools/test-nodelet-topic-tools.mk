TEST_NODELET_TOPIC_TOOLS_VERSION = 1.9.14
TEST_NODELET_TOPIC_TOOLS_SITE = https://github.com/ros/nodelet_core/archive
TEST_NODELET_TOPIC_TOOLS_SOURCE = $(TEST_NODELET_TOPIC_TOOLS_VERSION).tar.gz
TEST_NODELET_TOPIC_TOOLS_SUBDIR = test_nodelet_topic_tools
TEST_NODELET_TOPIC_TOOLS_DEPENDENCIES = message-filters nodelet nodelet-topic-tools pluginlib rostest roscpp

$(eval $(catkin-package))
