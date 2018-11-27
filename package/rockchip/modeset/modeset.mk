# Rockchip's modeset(Multimedia Processing Platform)
MODESET_SITE = $(TOPDIR)/package/rockchip/modeset/src
MODESET_VERSION = release
MODESET_SITE_METHOD = local

MODESET_CONF_DEPENDENCIES += libdrm

$(eval $(cmake-package))
