LINUX_RGA_SITE = $(TOPDIR)/../external/linux-rga
LINUX_RGA_VERSION = master
LINUX_RGA_SITE_METHOD = local

LINUX_RGA_LICENSE_FILES = COPYING
LINUX_RGA_LICENSE = GPLv2.1+

LINUX_RGA_DEPENDENCIES = libdrm

LINUX_RGA_BUILD_OPTS=-I$(STAGING_DIR)/usr/include/libdrm --sysroot=$(STAGING_DIR) -fPIC

LINUX_RGA_MAKE_OPTS = \
	CFLAGS="$(TARGET_CFLAGS) $(LINUX_RGA_BUILD_OPTS)" \
	CXXFLAGS="$(TARGET_CXXFLAGS) $(LINUX_RGA_BUILD_OPTS)" \
	PROJECT_DIR="$(@D)" \

define LINUX_RGA_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		$(LINUX_RGA_MAKE_OPTS)
endef

# it's better to implement by 'make install'
define LINUX_RGA_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/lib/librga.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 644 $(@D)/lib/librga.so $(STAGING_DIR)/usr/lib/
	$(INSTALL) -d $(STAGING_DIR)/usr/include/rga
	$(INSTALL) -C $(@D)/*.h $(STAGING_DIR)/usr/include/rga
endef

$(eval $(generic-package))
