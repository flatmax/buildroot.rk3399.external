################################################################################
#
# rockchip modules
#
################################################################################

ROCKCHIP_MODULES_VERSION = 1.0.0
ROCKCHIP_MODULES_SITE_METHOD = local
ROCKCHIP_MODULES_SITE = $(TOPDIR)/package/rockchip/rockchip_modules/src

ROCKCHIP_MODULES_EXT4_PATH = $(TOPDIR)/../kernel/fs/ext4/ext4.ko
ROCKCHIP_MODULES_JBD2_PATH = $(TOPDIR)/../kernel/fs/jbd2/jbd2.ko
ROCKCHIP_MODULES_MBCACHE2_PATH = $(TOPDIR)/../kernel/fs/mbcache2.ko
ROCKCHIP_MODULES_FAT_PATH = $(TOPDIR)/../kernel/fs/fat/fat.ko
ROCKCHIP_MODULES_VFAT_PATH = $(TOPDIR)/../kernel/fs/fat/vfat.ko
ROCKCHIP_MODULES_NTFS_PATH = $(TOPDIR)/../kernel/fs/ntfs/ntfs.ko

ifeq ($(BR2_PACKAGE_ROCKCHIP_MODULES_EXT4),y)
define ROCKCHIP_MODULES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/modules
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_JBD2_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_MBCACHE2_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_EXT4_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	$(INSTALL) -D -m 0755 $(@D)/S100load_modules $(TARGET_DIR)/etc/init.d
endef
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MODULES_FAT),y)
define ROCKCHIP_MODULES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/modules
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_FAT_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_VFAT_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	$(INSTALL) -D -m 0755 $(@D)/S100load_modules $(TARGET_DIR)/etc/init.d
endef
endif


ifeq ($(BR2_PACKAGE_ROCKCHIP_MODULES_NTFS),y)
define ROCKCHIP_MODULES_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/modules
	@$(INSTALL) -D -m 0644 $(ROCKCHIP_MODULES_NTFS_PATH) $(TARGET_DIR)/usr/lib/modules || echo "Err, Please cd kernel and make modules first"
	$(INSTALL) -D -m 0755 $(@D)/S100load_modules $(TARGET_DIR)/etc/init.d
endef
endif

$(eval $(generic-package))
