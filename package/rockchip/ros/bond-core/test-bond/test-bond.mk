TEST_BOND_VERSION = 1.8.3
TEST_BOND_SITE = https://github.com/ros/bond_core/archive
TEST_BOND_SOURCE = $(TEST_BOND_VERSION).tar.gz
TEST_BOND_SUBDIR = test_bond

TEST_BOND_DEPENDENCIES = cmake_modules bondcpp message-generation rostest

$(eval $(catkin-package))
