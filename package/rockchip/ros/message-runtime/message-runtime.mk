MESSAGE_RUNTIME_VERSION = 0.4.12
MESSAGE_RUNTIME_SOURCE = $(MESSAGE_RUNTIME_VERSION).tar.gz
MESSAGE_RUNTIME_SITE = https://github.com/ros/message_runtime/archive

MESSAGE_RUNTIME_DEPENDENCIES = gencpp cpp_common roscpp_serialization

$(eval $(catkin-package))
