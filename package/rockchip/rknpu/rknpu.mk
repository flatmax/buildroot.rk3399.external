################################################################################
#
# rknpu
#
################################################################################
RKNPU_VERSION = 1.2.1
RKNPU_SITE_METHOD = local
RKNPU_SITE = $(TOPDIR)/../external/rknpu
NPU_TEST_FILE = $(@D)/test

ifeq ($(BR2_PACKAGE_RK3399PRO_NPU),y)
NPU_KO_FILE = galcore_rk3399pro-npu.ko
NPU_INIT_FILE = S99NPU_init_rk3399pro-npu
else
NPU_KO_FILE = galcore.ko
NPU_INIT_FILE = S99NPU_init
endif

define RKNPU_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/lib/modules/
    mkdir -p $(TARGET_DIR)/usr/share/npu/
    $(INSTALL) -D -m 0644 $(@D)/drivers/$(NPU_KO_FILE) $(TARGET_DIR)/usr/lib/modules/galcore.ko
    $(INSTALL) -D -m 0644 $(@D)/drivers/*.so $(TARGET_DIR)/usr/lib/
    $(INSTALL) -D -m 0644 $(@D)/drivers/*.so $(STAGING_DIR)/usr/lib/
    $(INSTALL) -D -m 0644 $(@D)/rknn/usr/lib/*.so $(STAGING_DIR)/usr/lib/
    $(INSTALL) -D -m 0644 $(@D)/drivers/cl_*.h $(TARGET_DIR)/usr/lib/
    $(INSTALL) -D -m 0755 $(@D)/$(NPU_INIT_FILE) $(TARGET_DIR)/etc/init.d/S99NPU_init
    cp -r $(@D)/rknn/usr/* $(TARGET_DIR)/usr/

    if [ -e "$(@D)/test" ]; then \
	cp -r $(@D)/test $(TARGET_DIR)/usr/share/npu; \
    fi

endef

$(eval $(generic-package))
