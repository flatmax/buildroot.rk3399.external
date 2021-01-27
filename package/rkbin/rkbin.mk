################################################################################
#
# rkbin
#
################################################################################

RKBIN_VERSION = aae5f990fcf0dd604f7955cca7666b904d48ef09
RKBIN_SITE = https://github.com/rockchip-linux/rkbin.git
RKBIN_SITE_METHOD = git
RKBIN_INSTALL_IMAGES = YES

define RKBIN_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/rkbin
	cp -a $(@D)/* $(BINARIES_DIR)/rkbin
endef

$(eval $(generic-package))
