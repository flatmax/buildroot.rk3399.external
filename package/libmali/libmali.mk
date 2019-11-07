################################################################################
#
# libmali For Linux
#
################################################################################

LIBMALI_VERSION = 1d3f41704963d96039e1c0c6a2748337830da12b
LIBMALI_SITE = $(call github,flatmax,libmali-rk3399,$(LIBMALI_VERSION))
LIBMALI_DEPENDENCIES = host-pkgconf libdrm

define LIBMALI_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

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
	ln -s libgbm.so.1.0.0 libgbm.so.1 && \
	ln -s libgbm.so.1 libgbm.so && \
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

ifeq ($(BR2_PACKAGE_RK3399),y)
define LIBMALI_INSTALL_TARGET_CMDS
	rm -f $(LIBMALI_RM_SO)
	$(INSTALL) -D -m 644 $(@D)/lib/libgbm.so.1.0.0 $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 644 $(@D)/lib/libmali-midgard-t86x-r14p0-wayland.so $(TARGET_DIR)/usr/lib/
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-midgard-t86x-r14p0-wayland.so libmali.so && $(LIBMALI_LINK_SO) && $(LIBMALI_LINK_OPENCL_SO) && cd -
endef
else
	error do not know how to handle other archs.
endif
$(eval $(generic-package))
