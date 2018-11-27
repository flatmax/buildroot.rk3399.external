BROADCOM_BSA_SITE = $(TOPDIR)/../external/broadcom_bsa
BROADCOM_BSA_SITE_METHOD = local

BROADCOM_BSA_PATH = 3rdparty/embedded/bsa_examples/linux
BROADCOM_BSA_LIBBSA = libbsa
BROADCOM_BSA_APP = app_manager app_av app_avk app_ble app_dg \
		   app_hl app_hs app_tm app_tm app_socket \
		   app_hd app_hh app_ble_wifi_introducer

ifeq ($(BR2_PACKAGE_BROADCOM_BSA)$(BR2_PACKAGE_CYPRESS_BSA),yy)
$(error "You can only choose one type of BSA module (Broadcom or Cypress).")
endif

ifeq ($(call qstrip,$(BR2_ARCH)),arm)
BROADCOM_BSA_BUILD_TYPE = arm
endif
ifeq ($(call qstrip,$(BR2_ARCH)),aarch64)
BROADCOM_BSA_BUILD_TYPE = arm64
endif

ifeq ($(BR2_PACKAGE_BROADCOM_BSA_AP6255),y)
	BTFIRMWARE = BCM4345C0.hcd
endif

ifeq ($(BR2_PACKAGE_BROADCOM_BSA_AP6212A1),y)
	BTFIRMWARE = bcm43438a1.hcd
endif

ifeq ($(BR2_PACKAGE_BROADCOM_BSA_AP6354),y)
	BTFIRMWARE = bcm4354a1.hcd
endif

ifeq ($(BR2_PACKAGE_DUERCLIENTSDK),y)
        BROADCOM_BSA_DUERCLIENTSDK = $(BR2_PACKAGE_DUERCLIENTSDK)
        BROADCOM_BSA_BT_SINK_FILE = bsa_bt_sink_dueros.sh
        BROADCOM_BSA_BLE_WIFI_CONFIG_FILE = bsa_ble_wifi_introducer_dueros.sh
        BROADCOM_BSA_BT_HFP_FILE = bsa_bt_hfp_dueros.sh
else
        BROADCOM_BSA_BT_SINK_FILE = bsa_bt_sink.sh
        BROADCOM_BSA_BLE_WIFI_CONFIG_FILE = bsa_ble_wifi_introducer.sh
        BROADCOM_BSA_BT_HFP_FILE = bsa_bt_hfp.sh
endif

define BROADCOM_BSA_BUILD_CMDS
	for ff in $(BROADCOM_BSA_APP); do \
		$(MAKE) -C $(@D)/$(BROADCOM_BSA_PATH)/$$ff/build CPU=$(BROADCOM_BSA_BUILD_TYPE) ARMGCC=$(TARGET_CC) BSASHAREDLIB=TRUE DUERCLIENTSDK=$(BROADCOM_BSA_DUERCLIENTSDK); \
	done
endef

define BROADCOM_BSA_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/server/$(BROADCOM_BSA_BUILD_TYPE)/bsa_server \
		$(TARGET_DIR)/usr/bin/bsa_server
	$(INSTALL) -D -m 644 $(@D)/$(BROADCOM_BSA_PATH)/$(BROADCOM_BSA_LIBBSA)/build/$(BROADCOM_BSA_BUILD_TYPE)/sharedlib/libbsa.so \
		$(TARGET_DIR)/usr/lib/libbsa.so
	for ff in $(BROADCOM_BSA_APP); do \
		$(INSTALL) -D -m 755 $(@D)/$(BROADCOM_BSA_PATH)/$${ff}/build/$(BROADCOM_BSA_BUILD_TYPE)/$${ff} $(TARGET_DIR)/usr/bin/${ff}; \
	done

	mkdir -p $(TARGET_DIR)/etc/bsa_file
	$(INSTALL) -D -m 644 $(TOPDIR)/../external/broadcom_bsa/test_files/av/8k8bpsMono.wav $(TARGET_DIR)/etc/bsa_file/
	$(INSTALL) -D -m 644 $(TOPDIR)/../external/broadcom_bsa/test_files/av/8k16bpsStereo.wav $(TARGET_DIR)/etc/bsa_file/
	$(INSTALL) -D -m 755 package/rockchip/broadcom_bsa/$(BROADCOM_BSA_BT_HFP_FILE) $(TARGET_DIR)/usr/bin/bsa_bt_hfp.sh
	$(INSTALL) -D -m 755 package/rockchip/broadcom_bsa/bsa_server.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 755 package/rockchip/broadcom_bsa/$(BROADCOM_BSA_BT_SINK_FILE) $(TARGET_DIR)/usr/bin/bsa_bt_sink.sh
	$(INSTALL) -D -m 755 package/rockchip/broadcom_bsa/bsa_bt_source.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 755 package/rockchip/broadcom_bsa/$(BROADCOM_BSA_BLE_WIFI_CONFIG_FILE) $(TARGET_DIR)/usr/bin/bsa_ble_wifi_introducer.sh
	sed -i 's/BTFIRMWARE_PATH/\/system\/etc\/firmware\/$(BTFIRMWARE)/g' $(TARGET_DIR)/usr/bin/bsa_bt_hfp.sh
	sed -i 's/BTFIRMWARE_PATH/\/system\/etc\/firmware\/$(BTFIRMWARE)/g' $(TARGET_DIR)/usr/bin/bsa_server.sh
	sed -i 's/BTFIRMWARE_PATH/\/system\/etc\/firmware\/$(BTFIRMWARE)/g' $(TARGET_DIR)/usr/bin/bsa_bt_sink.sh
	sed -i 's/BTFIRMWARE_PATH/\/system\/etc\/firmware\/$(BTFIRMWARE)/g' $(TARGET_DIR)/usr/bin/bsa_bt_source.sh
	sed -i 's/BTFIRMWARE_PATH/\/system\/etc\/firmware\/$(BTFIRMWARE)/g' $(TARGET_DIR)/usr/bin/bsa_ble_wifi_introducer.sh

endef

$(eval $(generic-package))
