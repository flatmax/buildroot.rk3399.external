# Rockchip's MPP(Multimedia Processing Platform)
MPP_VERSION = 1babbc9cc277692d02fc4727daef2e91f91ce8b0
MPP_SITE = $(call github,rockchip-linux,libmali,$(MPP_VERSION))

MPP_CONF_OPTS = "-DRKPLATFORM=ON"
MPP_CONF_DEPENDENCIES += libdrm

MPP_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_MPP_ALLOCATOR_DRM),y)
MPP_CONF_OPTS += "-DHAVE_DRM=ON"
endif

$(eval $(cmake-package))
