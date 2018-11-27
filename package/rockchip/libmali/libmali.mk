################################################################################
#
# libmali For Linux
#
################################################################################

LIBMALI_VERSION = develop
LIBMALI_SITE = $(TOPDIR)/../external/libmali
LIBMALI_SITE_METHOD = local

define LIBMALI_RM_SO
	$(TARGET_DIR)/usr/lib/libmali* \
	$(TARGET_DIR)/usr/lib/libMali* \
	$(TARGET_DIR)/usr/lib/libEGL.so* \
	$(TARGET_DIR)/usr/lib/libgbm.so* \
	$(TARGET_DIR)/usr/lib/libGLESv1_CM.so* \
	$(TARGET_DIR)/usr/lib/libGLESv2.so* \
	$(TARGET_DIR)/usr/lib/libMaliOpenCL.so \
	$(TARGET_DIR)/usr/lib/libOpenCL.so \
	$(TARGET_DIR)/usr/lib/libwayland-egl.so*
endef

define LIBMALI_LINK_SO
	ln -s libmali.so libMali.so && \
	ln -s libmali.so libEGL.so && \
	ln -s libmali.so libEGL.so.1 && \
	ln -s libmali.so libgbm.so && \
	ln -s libmali.so libgbm.so.1 && \
	ln -s libmali.so libGLESv1_CM.so && \
	ln -s libmali.so libGLESv1_CM.so.1 && \
	ln -s libmali.so libGLESv2.so && \
	ln -s libmali.so libGLESv2.so.2 && \
	ln -s libmali.so libwayland-egl.so && \
	ln -s libmali.so libwayland-egl.so.1
endef

define LIBMALI_LINK_OPENCL_SO
	ln -s libmali.so libMaliOpenCL.so && \
	ln -s libmali.so libOpenCL.so
endef

ifeq ($(BR2_PACKAGE_RK3308),y)
define LIBMALI_INSTALL_TARGET_CMDS
endef
endif

ifeq ($(BR2_aarch64),y)
ifeq ($(BR2_PACKAGE_RK3326),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-bifrost-g31-rxp0-wayland-gbm.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-bifrost-g31-rxp0-wayland-gbm.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif
else
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-bifrost-g31-rxp0-wayland-gbm.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-bifrost-g31-rxp0-wayland-gbm.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif

ifeq ($(BR2_aarch64),y)
ifeq ($(BR2_PACKAGE_PX30),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
        $(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-bifrost-g31-rxp0-wayland-gbm.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-bifrost-g31-rxp0-wayland-gbm.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif
else
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-bifrost-g31-rxp0-wayland-gbm.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-bifrost-g31-rxp0-wayland-gbm.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif

ifeq ($(BR2_PACKAGE_PX3SE),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-utgard-400-r7p0-r3p0-wayland.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 755 $(@D)/overlay/S10libmali_px3se $(TARGET_DIR)/etc/init.d/S10libmali
	$(INSTALL) -D -m 755 $(@D)/overlay/px3seBase $(TARGET_DIR)/usr/sbin/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-utgard-400-r7p0-r3p0-wayland.so libmali.so && $(LIBMALI_LINK_SO) && cd -
endef
endif

ifeq ($(BR2_PACKAGE_RK3128),y)
define LIBMALI_INSTALL_TARGET_CMDS
        rm -f $(LIBMALI_RM_SO)
        $(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-utgard-400-r7p0-r1p1-wayland.so $(TARGET_DIR)/usr/lib/
        cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-utgard-400-r7p0-r1p1-wayland.so libmali.so && $(LIBMALI_LINK_SO) && cd -
endef
endif

ifeq ($(BR2_PACKAGE_RK3288),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-midgard-t76x-r14p0-r0p0-wayland.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 644 $(@D)/lib/arm-linux-gnueabihf/libmali-midgard-t76x-r14p0-r1p0-wayland.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 755 $(@D)/overlay/S10libmali_rk3288 $(TARGET_DIR)/etc/init.d/S10libmali
	cd $(TARGET_DIR)/usr/lib/ && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif

ifeq ($(BR2_PACKAGE_RK3399),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-midgard-t86x-r14p0-wayland.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-midgard-t86x-r14p0-wayland.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif

ifeq ($(BR2_PACKAGE_RK3328),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-utgard-450-r7p0-r0p0-wayland.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-utgard-450-r7p0-r0p0-wayland.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
endif

$(eval $(generic-package))
