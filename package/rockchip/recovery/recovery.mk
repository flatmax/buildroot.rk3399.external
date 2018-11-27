################################################################################
#
# Rockchip Recovery For Linux
#
################################################################################

RECOVERY_VERSION = develop
RECOVERY_SITE = $(TOPDIR)/../external/recovery
RECOVERY_SITE_METHOD = local

RECOVERY_LICENSE = Apache V2.0
RECOVERY_LICENSE_FILES = NOTICE
CC="$(TARGET_CC)"
PROJECT_DIR="$(@D)"
RECOVERY_BUILD_OPTS+=-I$(PROJECT_DIR) -I$(STAGING_DIR)/usr/include/libdrm \
	--sysroot=$(STAGING_DIR) \
	-fPIC \
	-lpthread

ifeq ($(BR2_PACKAGE_RK3308),y)
	TARGET_MAKE_ENV += RecoveryNoUi=true
else
	RECOVERY_BUILD_OPTS += -lz -lpng -ldrm
	RECOVERY_DEPENDENCIES += libzlib libpng libdrm
endif

RECOVERY_MAKE_OPTS = \
        CFLAGS="$(TARGET_CFLAGS) $(RECOVERY_BUILD_OPTS)" \
        PROJECT_DIR="$(@D)"

define RECOVERY_IMAGE_COPY
        mkdir -p $(TARGET_DIR)/res/images
        cp $(BUILD_DIR)/recovery-$(RECOVERY_VERSION)/res/images/* $(TARGET_DIR)/res/images/
endef

define RECOVERY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC="$(TARGET_CC)" $(RECOVERY_MAKE_OPTS)
endef

define RECOVERY_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 755 $(@D)/recovery $(TARGET_DIR)/usr/bin/ && $(RECOVERY_IMAGE_COPY)
endef

ifeq ($(BR2_PACKAGE_RECOVERY),y)
define RECOVERY_IMAGE_PACK
	mkdir -p $(TARGET_DIR)/res/images
	cp $(BUILD_DIR)/recovery-$(RECOVERY_VERSION)/res/images/* $(TARGET_DIR)/res/images/
	$(HOST_DIR)/bin/mkbootfs $(TARGET_DIR) | $(HOST_DIR)/bin/minigzip > $(BINARIES_DIR)/ramdisk-recovery.img
	$(RECOVERY_MKBOOTIMG) --kernel $(RECOVERY_MK_KERNEL_IMAGE) --ramdisk $(BINARIES_DIR)/ramdisk-recovery.img --second $(RECOVERY_RESOURCEIMG) --os_version $(RECOVERY_OS_VERSION) --os_patch_level $(RECOVERY_OS_PATCH_LEVEL) --cmdline $(RECOVERY_CMDLINNE) --output $(BINARIES_DIR)/recovery.img
	$(RECOVERY_MK_KERNEL_IMAGE) $(BINARIES_DIR)/ramdisk-recovery.img $(BINARIES_DIR)/recovery.img
endef

#TARGET_FINALIZE_HOOKS += RECOVERY_IMAGE_PACK
endif

$(eval $(generic-package))
