################################################################################
#
# Rockchip ALSA LADSPA
#
################################################################################

ALSA_LADSPA_VERSION = 1.1
ALSA_LADSPA_SITE = $(TOPDIR)/../external/ladspaSDK
ALSA_LADSPA_SITE_METHOD = local

ALSA_LADSPA_LICENSE = Apache V2.0
ALSA_LADSPA_LICENSE_FILES = NOTICE

ifeq ($(call qstrip,$(BR2_ARCH)),aarch64)
define ALSA_LADSPA_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 644 $(@D)/Equalizer.so $(TARGET_DIR)/usr/lib/Equalizer.so
endef
endif

ifeq ($(call qstrip,$(BR2_ARCH)),arm)
define ALSA_LADSPA_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 644 $(@D)/Equalizer_32.so $(TARGET_DIR)/usr/lib/Equalizer.so
endef
endif

$(eval $(generic-package))
