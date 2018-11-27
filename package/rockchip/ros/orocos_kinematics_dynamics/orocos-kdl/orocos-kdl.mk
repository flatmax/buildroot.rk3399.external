OROCOS_KDL_VERSION = 1.3.0

OROCOS_KDL_SITE = https://github.com/orocos/orocos_kinematics_dynamics/archive
OROCOS_KDL_SOURCE = $(OROCOS_KDL_VERSION).tar.gz
OROCOS_KDL_SUBDIR = orocos_kdl
OROCOS_KDL_INSTALL_STAGING = YES

OROCOS_KDL_CONF_OPTS += \
	-DSTAGING_DIR="$(STAGING_DIR)"

OROCOS_KDL_DEPENDENCIES = eigen

$(eval $(cmake-package))
