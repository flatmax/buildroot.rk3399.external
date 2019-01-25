################################################################################
#
# nanopi helper scripts
#
################################################################################

NANOPI_SCRIPTS_VERSION = 0.0
NANOPI_SCRIPTS_SITE=$(BR2_EXTERNAL)/package/nanopi_scripts
NANOPI_SCRIPTS_SITE_METHOD=local

#define NANOPI_SCRIPTS_EXTRACT_CMDS
#endef

#define NANOPI_SCRIPTS_CONFIGURE_CMDS
#endef

define NANOPI_SCRIPTS_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 755 $(@D)/*Weston.sh $(TARGET_DIR)/usr/bin/
endef


ifeq ($(BR2_PACKAGE_NANOPI_SCRIPTS_INIT_WESTON),y)
  define NANOPI_SCRIPTS_INSTALL_INIT_SYSV
    $(INSTALL) -D -m 755 $(@D)/S60weston $(TARGET_DIR)/etc/init.d/S60weston
  endef
endif

$(eval $(generic-package))
