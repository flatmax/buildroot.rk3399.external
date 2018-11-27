TEST_NODELET_VERSION = 1.9.14
TEST_NODELET_SITE = https://github.com/ros/nodelet_core/archive
TEST_NODELET_SOURCE = $(TEST_NODELET_VERSION).tar.gz
TEST_NODELET_SUBDIR = test_nodelet
TEST_NODELET_DEPENDENCIES = boost nodelet pluginlib rostest

$(eval $(catkin-package))
