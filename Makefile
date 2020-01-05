INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

ARCHS = armv7 armv7s arm64

TWEAK_NAME = MarkAsRead13

MarkAsRead13_FILES = Tweak.x
MarkAsRead13_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
			install.exec "killall -9 SpringBoard"
