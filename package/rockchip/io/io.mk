################################################################################
#
# io
#
################################################################################

IO_LICENSE_FILES = NOTICE
IO_LICENSE = Apache V2.0

define IO_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) \
		package/rockchip/io/io.c -o $(@D)/io
endef

define IO_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/io $(TARGET_DIR)/usr/bin/io
endef

$(eval $(generic-package))
