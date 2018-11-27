# Rockchip's libcutils porting from Android
# Author : Cody Xie <cody.xie@rock-chips.com>

LIBCUTILS_SITE = $(TOPDIR)/../external/libcutils
LIBCUTILS_SITE_METHOD = local
LIBCUTILS_DEPENDENCIES += liblog
LIBCUTILS_VERSION = 2c61c38
LIBCUTILS_INSTALL_STAGING = YES

$(eval $(cmake-package))
