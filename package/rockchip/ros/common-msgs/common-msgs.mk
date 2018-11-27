#COMMON_MSGS_VERSION = 1.11.9
#COMMON_MSGS_SOURCE = $(COMMON_MSGS_VERSION).tar.gz
#COMMON_MSGS_SITE = https://github.com/ros/common_msgs/archive 

include $(sort $(wildcard package/rockchip/ros/common-msgs/*/*.mk))
