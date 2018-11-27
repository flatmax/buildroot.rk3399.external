################################################################################
#
# Rockchip Camera Engine RKisp For Linux
#
################################################################################

CAMERA_ENGINE_RKISP_VERSION = 1.0
CAMERA_ENGINE_RKISP_SITE = $(TOPDIR)/../external/camera_engine_rkisp
CAMERA_ENGINE_RKISP_SITE_METHOD = local

CAMERA_ENGINE_RKISP_LICENSE = Apache V2.0
CAMERA_ENGINE_RKISP_LICENSE_FILES = NOTICE

CAMERA_ENGINE_RKISP_MAKE_OPTS = \
	TARGET_GCC="$(TARGET_CC)" \
	TARGET_GPP="$(TARGET_CXX)" \
	TARGET_AR="$(TARGET_AR)" \
	TARGET_LD="$(TARGET_LD)" \

ifeq ($(BR2_PACKAGE_RK3326),y)
CAMERA_ENGINE_RKISP_CONF_OPTS = \
		IS_RKISP_v12=true
endif

ifeq ($(BR2_PACKAGE_PX30),y)
CAMERA_ENGINE_RKISP_CONF_OPTS = \
		IS_RKISP_v12=true
endif

ifeq ($(call qstrip,$(BR2_ARCH)),arm)
CAMERA_ENGINE_RKISP_LIB = lib32
CAMERA_ENGINE_RKISP_GLIB_H = glib-2.0-32
else
CAMERA_ENGINE_RKISP_LIB = lib64
CAMERA_ENGINE_RKISP_GLIB_H = glib-2.0-64
endif

export BUILD_OUPUT_GSTREAMER_LIBS:=$(@D)/ext/rkisp/usr/$(CAMERA_ENGINE_RKISP_LIB)/gstreamer-1.0
export BUILD_OUPUT_EXTERNAL_LIBS:=$(@D)/ext/rkisp/usr/$(CAMERA_ENGINE_RKISP_LIB)

define CAMERA_ENGINE_RKISP_CONFIGURE_CMDS
	rm -rf $(@D)/ext/rkisp/usr/lib
	rm -rf $(@D)/ext/rkisp/usr/include/glib-2.0
	cp -rf $(@D)/ext/rkisp/usr/include/$(CAMERA_ENGINE_RKISP_GLIB_H) $(@D)/ext/rkisp/usr/include/glib-2.0
	cp -rf $(@D)/ext/rkisp/usr/$(CAMERA_ENGINE_RKISP_LIB) $(@D)/ext/rkisp/usr/lib
endef

define CAMERA_ENGINE_RKISP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
	$(CAMERA_ENGINE_RKISP_MAKE_OPTS) \
	$(CAMERA_ENGINE_RKISP_CONF_OPTS)
endef

RKgstDir = $(TARGET_DIR)/usr/lib/gstreamer-1.0
RKafDir = $(TARGET_DIR)/usr/lib/rkisp/af
RKaeDir = $(TARGET_DIR)/usr/lib/rkisp/ae
RKawbDir = $(TARGET_DIR)/usr/lib/rkisp/awb

define CAMERA_ENGINE_RKISP_INSTALL_TARGET_CMDS
	mkdir -p $(RKgstDir)
	mkdir -p $(RKafDir)
	mkdir -p $(RKaeDir)
	mkdir -p $(RKawbDir)
	mkdir -p $(TARGET_DIR)/etc/iqfiles
	$(INSTALL) -D -m 755 $(TOPDIR)/package/rockchip/camera_engine_rkisp/set_pipeline.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 755 $(TOPDIR)/package/rockchip/camera_engine_rkisp/camera_rkisp.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 755 $(TOPDIR)/package/rockchip/camera_engine_rkisp/S50set_pipeline $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 644 $(@D)/iqfiles/*.xml $(TARGET_DIR)/etc/iqfiles/
	$(INSTALL) -D -m 644 $(@D)/build/lib/librkisp.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 644 $(@D)/plugins/3a/rkiq/af/$(CAMERA_ENGINE_RKISP_LIB)/librkisp_af.so $(RKafDir)/
	$(INSTALL) -D -m 644 $(@D)/plugins/3a/rkiq/aec/$(CAMERA_ENGINE_RKISP_LIB)/librkisp_ae.so $(RKaeDir)/
	$(INSTALL) -D -m 644 $(@D)/plugins/3a/rkiq/awb/$(CAMERA_ENGINE_RKISP_LIB)/librkisp_awb.so $(RKawbDir)/
	$(INSTALL) -D -m 644 $(@D)/build/lib/libgstrkisp.so $(RKgstDir)/
endef

$(eval $(autotools-package))
