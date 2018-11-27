# Rockchip's MPP(Multimedia Processing Platform)
MPP_SITE = $(TOPDIR)/../external/mpp
MPP_VERSION = release
MPP_SITE_METHOD = local

MPP_CONF_OPTS = "-DRKPLATFORM=ON"
MPP_CONF_DEPENDENCIES += libdrm

MPP_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_MPP_ALLOCATOR_DRM),y)
MPP_CONF_OPTS += "-DHAVE_DRM=ON"
endif

$(eval $(cmake-package))
