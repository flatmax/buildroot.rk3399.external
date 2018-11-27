################################################################################
#
# rkscript
#
################################################################################

RKSCRIPT_SITE = $(TOPDIR)/package/rockchip/rkscript
RKSCRIPT_SITE_METHOD = local

define RKSCRIPT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/*.sh $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
