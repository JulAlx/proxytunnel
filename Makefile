#
# Copyright (C) 2014 OpenWrt-dist
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=proxytunnel
PKG_VERSION:=1.99
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/proxytunnel/proxytunnel.git
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=master
#PKG_SOURCE_VERSION:=3052eeab75ff1ebd20c22334fbbecd808525bca7
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=Jos Visser <josv@osp.nl>, Mark Janssen <maniac@maniac.nl>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/proxytunnel
	SECTION:=net
	CATEGORY:=Network
	TITLE:=HTTPS proxy client
	URL:=https://github.com/proxytunnel/proxytunnel.git
	DEPENDS:=+libevent2 +libopenssl +cryptodev-linux
endef

define Package/proxytunnel/description
This is proxytunnel, a program that connects stdin and stdout \
to an origin server somewhere in the Internet through an industry \
standard HTTPS proxy. I originally wrote this program to be used \
as an extension to SSH, to be able to SSH to my box at home. In \
this file, I will describe the use with SSH. If you want to use it \
with some other application, feel free, and let me know! \
endef

define Package/proxytunnel/conffiles
/etc/config/proxytunnel
endef


define Package/proxytunnel/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/proxytunnel $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/proxytunnel
	$(INSTALL_DATA) ./files/proxytunnel.template $(1)/etc/proxytunnel/config.template
endef

$(eval $(call BuildPackage,proxytunnel))
