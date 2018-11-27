################################################################################
#
# usbdevice
#
################################################################################

USBDEVICE_VERSION = 0.0.1
USBDEVICE_SITE = $(TOPDIR)/package/rockchip/usbdevice
USBDEVICE_SITE_METHOD = local
USBDEVICE_LICENSE = Apache V2.0
USBDEVICE_LICENSE_FILES = NOTICE
USBDEVICE_USB_CONFIG_FILE = $(TARGET_DIR)/etc/init.d/.usb_config

define USBDEVICE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/S50usbdevice $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -m 0644 -D $(@D)/61-usbdevice.rules $(TARGET_DIR)/lib/udev/rules.d/
	$(INSTALL) -m 0755 -D $(@D)/usbdevice $(TARGET_DIR)/usr/bin/

	if test -e $(USBDEVICE_USB_CONFIG_FILE) ; then \
		rm $(USBDEVICE_USB_CONFIG_FILE) ; \
	fi
	touch $(USBDEVICE_USB_CONFIG_FILE)
endef

ifeq ($(BR2_PACKAGE_ANDROID_TOOLS_ADBD),y)
define USBDEVICE_ADD_ADBD_CONFIG
	if test ! `grep usb_adb_en $(USBDEVICE_USB_CONFIG_FILE)` ; then \
		echo usb_adb_en >> $(USBDEVICE_USB_CONFIG_FILE) ; \
	fi
endef
USBDEVICE_POST_INSTALL_TARGET_HOOKS += USBDEVICE_ADD_ADBD_CONFIG
endif

ifeq ($(BR2_PACKAGE_MTP),y)
define USBDEVICE_ADD_MTP_CONFIG
	if test ! `grep usb_mtp_en $(USBDEVICE_USB_CONFIG_FILE)` ; then \
		echo usb_mtp_en >> $(USBDEVICE_USB_CONFIG_FILE) ; \
	fi
endef
USBDEVICE_POST_INSTALL_TARGET_HOOKS += USBDEVICE_ADD_MTP_CONFIG
endif

ifeq ($(BR2_PACKAGE_USB_MASS_STORAGE),y)
define USBDEVICE_ADD_UMS_CONFIG
	if test ! `grep usb_ums_en $(USBDEVICE_USB_CONFIG_FILE)` ; then \
		echo usb_ums_en >> $(USBDEVICE_USB_CONFIG_FILE) ; \
	fi
endef
USBDEVICE_POST_INSTALL_TARGET_HOOKS += USBDEVICE_ADD_UMS_CONFIG
endif

$(eval $(generic-package))
