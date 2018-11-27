MINIGUI_SITE = $(TOPDIR)/../external/minigui
MINIGUI_VERSION = master
MINIGUI_SITE_METHOD = local
MINIGUI_INSTALL_STAGING = YES

MINIGUI_LICENSE_FILES = COPYING
MINIGUI_LICENSE = GPLv3
MINIGUI_AUTORECONF = YES
MINIGUI_DEPENDENCIES = jpeg

ifeq ($(BR2_PACKAGE_MINIGUI_ENABLE_RGA),y)
MINIGUI_DEPENDENCIES += linux-rga
MINIGUI_CONF_ENV = CFLAGS+=" -DENABLE_RGA=1"
endif

##    --host=arm-linux
##    --target=arm-linux
MINIGUI_CONF_OPTS = \
    --with-sysroot=$(STAGING_DIR) \
    --build=i386-linux \
    --with-osname=linux \
    --with-targetname=drmcon \
    --disable-videopcxvfb \
    --with-ttfsupport=none \
    --enable-autoial \
    --disable-vbfsupport \
    --disable-tslibial \
    --disable-textmode \
    --enable-vbfsupport \
    --disable-pcxvfb \
    --disable-dlcustomial \
    --disable-dummyial \
    --disable-jpgsupport \
    --disable-fontcourier \
    --disable-screensaver \
    --enable-cisco_touchpad_ial \
    --enable-jpgsupport \
    --disable-fontsserif \
    --disable-fontsystem \
    --disable-flatlf \
    --disable-skinlfi \
    --disable-mousecalibrate \
    --disable-dblclk \
    --disable-consoleps2 \
    --disable-consolems \
    --disable-consolems3 \
    --disable-rbfterminal \
    --disable-rbffixedsys \
    --disable-vbfsupport \
    --disable-splash \
    --enable-videoshadow \
    --disable-static \
    --enable-shared \
    --disable-procs \
    --disable-cursor \
    --with-runmode=ths \
    --disable-videofbcon \
    --enable-videodrmcon \
    --disable-incoreres \
    --with-pic

ifeq ($(BR2_PACKAGE_MINIGUI_ENABLE_FREETYPE),y)
MINIGUI_DEPENDENCIES += freetype
MINIGUI_CONF_OPTS += \
    --enable-ttfsupport \
    --with-ttfsupport=ft2 \
    --with-ft2-includes=$(STAGING_DIR)/usr/include/freetype2
endif

ifeq ($(BR2_PACKAGE_MINIGUI_ENABLE_PNG),y)
MINIGUI_DEPENDENCIES += libpng12
MINIGUI_CONF_OPTS += \
    --enable-pngsupport
endif

$(eval $(autotools-package))
