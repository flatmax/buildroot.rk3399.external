GENLISP_VERSION = 0.4.15
GENLISP_SITE = https://github.com/ros/genlisp/archive
GENLISP_SOURCE = $(GENLISP_VERSION).tar.gz

GENLISP_DEPENDENCIES = genmsg

$(eval $(catkin-package))
