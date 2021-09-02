INSTALL_PREFIX := /opt/retropie/emulators/gsplus

CONFIG_FILES := config.txt template-slot6 template-slot7
CONFIG_PREFIX := /opt/retropie/configs/apple2

install:
	install -d ${INSTALL_PREFIX}/bin
	install ../../build/bin/GSplus ${INSTALL_PREFIX}/bin
	install gsplus.sh ${INSTALL_PREFIX}
	install ${CONFIG_FILES} ${CONFIG_PREFIX}

