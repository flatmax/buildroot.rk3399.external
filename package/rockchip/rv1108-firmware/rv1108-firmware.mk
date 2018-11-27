# RV1108 BSP packages
# Author : Cody Xie <cody.xie@rock-chips.com>

ifeq ($(BR2_PACKAGE_RV1108_FIRMWARE),y)
RV1108_FIRMWARE_FILES+=package/rockchip/rv1108-firmware/dsp/firmware/rkdsp.bin
endif

ifneq ($(RV1108_FIRMWARE_FILES)$(RV1108_FIRMWARE_LIBS)$(RV1108_FIRMWARE_INITSCRIPT),)
define RV1108_FIRMWARE_INSTALL_TARGET_FILES
$(foreach firmware,$(RV1108_FIRMWARE_FILES), \
	$(INSTALL) -D -m 0644 $(firmware) \
		$(TARGET_DIR)/lib/firmware/
)
$(foreach lib,$(RV1108_FIRMWARE_LIBS), \
	$(INSTALL) -D -m 0644 $(lib) \
		$(TARGET_DIR)/usr/lib/
)
$(foreach init,$(RV1108_FIRMWARE_INITSCRIPT), \
	$(INSTALL) -D -m 0755 $(init) \
		$(TARGET_DIR)/etc/init.d/
)
endef
endif

ifneq ($(RV1108_STAGING_INCLUDE_DIR)$(RV1108_STAGING_LIBS),)
RV1108_FIRMWARE_INSTALL_STAGING = YES
define RV1108_FIRMWARE_INSTALL_STAGING_FILES
$(foreach l,$(RV1108_STAGING_LIBS), \
	$(INSTALL) -D -m 0755 $(l) \
		$(STAGING_DIR)/usr/lib/
)
$(foreach d,$(RV1108_STAGING_INCLUDE_DIR), \
	rm -rf $(STAGING_DIR)/usr/include/$(shell basename $(d)); \
	cp -a $(d) $(STAGING_DIR)/usr/include/$(shell basename $(d))$(sep)
)
endef
endif

ifneq ($(RV1108_FIRMWARE_INSTALL_TARGET_FILES),)
define RV1108_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	$(RV1108_FIRMWARE_INSTALL_TARGET_FILES)
endef
endif

ifneq ($(RV1108_FIRMWARE_INSTALL_STAGING_FILES),)
define RV1108_FIRMWARE_INSTALL_STAGING_CMDS
	$(RV1108_FIRMWARE_INSTALL_STAGING_FILES)
endef
endif

$(eval $(generic-package))
