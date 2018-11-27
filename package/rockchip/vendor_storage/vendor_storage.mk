################################################################################
#
# vendor storage
#
################################################################################

define VENDOR_STORAGE_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		package/rockchip/vendor_storage/vendor_storage.c -o $(@D)/vendor_storage
endef

define VENDOR_STORAGE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/vendor_storage $(TARGET_DIR)/usr/bin/vendor_storage
endef

$(eval $(generic-package))
