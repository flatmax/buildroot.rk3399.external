################################################################################
#
# update
#
################################################################################

UPDATE_LICENSE_FILES = NOTICE
UPDATE_LICENSE = Apache V2.0

UPDATE_BUILD_OPTS+=-I$(PROJECT_DIR)/update_recv/

define UPDATE_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) $(RECOVERY_BUILD_OPTS) \
		package/rockchip/update/update.c package/rockchip/update/update_recv/update_recv.c -o $(@D)/update
endef

define UPDATE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/update $(TARGET_DIR)/usr/bin/update
endef

$(eval $(generic-package))
