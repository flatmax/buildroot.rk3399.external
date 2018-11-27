################################################################################
#
# glmarktest
#
################################################################################

GLMARKTEST_VERSION = 0.1
GLMARKTEST_SITE = $(TOPDIR)/package/rockchip/glmarktest
GLMARKTEST_SITE_METHOD = local

define GLMARKTEST_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/glmarktest $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
