MTP_VERSION = 71
MTP_SITE = https://launchpad.net/mtp
MTP_SITE_METHOD = bzr
MTP_INSTALL_STAGING = YES

MTP_DEPENDENCIES = boost dbus-cpp glog

$(eval $(cmake-package))
