MESSAGE_GENERATION_VERSION = 0.4.0
ifeq ($(BR2_PACKAGE_ROS_INDIGO),y)
MESSAGE_GENERATION_VERSION = 0.2.10	#groovy
endif

MESSAGE_GENERATION_SOURCE = $(MESSAGE_GENERATION_VERSION).tar.gz
MESSAGE_GENERATION_SITE = https://github.com/ros/message_generation/archive

MESSAGE_GENERATION_DEPENDENCIES = gencpp genlisp genpy

ifeq ($(BR2_PACKAGE_ROS_KINETIC),y)
MESSAGE_GENERATION_DEPENDENCIES += geneus gennodejs
endif

$(eval $(catkin-package))
