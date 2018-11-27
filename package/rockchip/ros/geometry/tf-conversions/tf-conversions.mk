TF_CONVERSIONS_VERSION = 1.11.9
TF_CONVERSIONS_SOURCE = $(TF_CONVERSIONS_VERSION).tar.gz
TF_CONVERSIONS_SITE = https://github.com/ros/geometry/archive
TF_CONVERSIONS_SUBDIR = tf_conversions
TF_CONVERSIONS_DEPENDENCIES = orocos-kdl cmake_modules geometry-msgs tf kdl-conversions
TF_CONVERSIONS_CONF_OPTS = -DEIGEN3_INCLUDE_DIRS=$(STAGING_DIR)/usr/include/eigen3

$(eval $(catkin-package))
