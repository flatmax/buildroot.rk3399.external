################################################################################
#
# sd_fuse-rk3399
#
################################################################################
SD_FUSE_RK3399_VERSION = 50dba2a64ab6128690407ba40ab190171749e07c
SD_FUSE_RK3399_SITE =  $(call github,friendlyarm,sd-fuse_rk3399,$(SD_FUSE_RK3399_VERSION))
SD_FUSE_RK3399_LICENSE = GPL-2.0+
SD_FUSE_RK3399_INSTALL_IMAGES = YES

define SD_FUSE_RK3399_INSTALL_IMAGES_CMDS
  $(INSTALL) -d $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
  $(INSTALL) -d $(BINARIES_DIR)/sd-fuse-rk3399/tools
  $(INSTALL) -D -m 0755 $(@D)/*.sh $(BINARIES_DIR)/sd-fuse-rk3399
  $(INSTALL) -D -m 0755 $(@D)/tools/* $(BINARIES_DIR)/sd-fuse-rk3399/tools
  $(INSTALL) -D -m 0444 $(@D)/prebuilt/idbloader.img $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
  $(INSTALL) -D -m 0444 $(@D)/prebuilt/generic/*.txt $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
endef

$(eval $(generic-package))
