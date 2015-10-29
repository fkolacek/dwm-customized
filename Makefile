# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

dwm: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz *.orig *.rej

scripts:
	@sed -i "s#DWM_BINARY_FROM_CONFIG#${DESTDIR}${PREFIX}/bin/dwm#g" scripts/dwm-loader
	@sed -i "s/WEB_BROWSER_FROM_CONFIG/${WEB_BROWSER}/g" scripts/dwm-open-browser

install: all
	@echo
	@echo ":: [ DWM core ] ::"
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f dwm ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	@echo
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@echo
	@echo ":: [ DWM session  ] ::"
	@echo installing dwm.desktop to ${DESTDIR}${XSESSIONS}
	@cp -f scripts/dwm.desktop ${DESTDIR}${XSESSIONS}/dwm.desktop
	@echo installing dwm-loader to ${DESTDIR}${PREFIX}/bin
	@sed "s#DWM_BINARY_FROM_CONFIG#${DESTDIR}${PREFIX}/bin/dwm#g" < scripts/dwm-loader > ${DESTDIR}${PREFIX}/bin/dwm-loader
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm-loader
	@echo
	@echo ":: [ DWM panel ] ::"
	@echo installing dwm-panel to ${DESTDIR}${PREFIX}/bin
	@cp -f scripts/dwm-panel ${DESTDIR}${PREFIX}/bin/dwm-panel
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm-panel
	@cp -f scripts/dwm-panel.service ${DESTDIR}${SYSTEMD_SERVICES}/dwm-panel.service
	@echo
	@echo ":: [ SCRIPTS ] ::"
	@echo "Installing 'dwm-open-browser' to ${PREFIX}/bin/dwm-open-browser"
	@sed "s/WEB_BROWSER_FROM_CONFIG/${WEB_BROWSER}/g" < scripts/dwm-open-browser > ${DESTDIR}${PREFIX}/bin/dwm-open-browser
	@cp -f scripts/dwm-switch-keyboard ${DESTDIR}${PREFIX}/bin/dwm-switch-keyboard
	@cp -f scripts/dwm-menu ${DESTDIR}${PREFIX}/bin/dwm-menu
	@chmod +x ${DESTDIR}${PREFIX}/bin/dwm-open-browser
	@chmod +x ${DESTDIR}${PREFIX}/bin/dwm-switch-keyboard
	@chmod +x ${DESTDIR}${PREFIX}/bin/dwm-menu

uninstall:
	@echo "Warning! This script is not reliable - does NOT remove all files."
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@echo removing other files
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm-loader
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm-open-browser
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm-switch-keyboard
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm-panel
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm-menu
	@rm -f ${DESTDIR}${XSESSIONS}/dwm.desktop
	@rm -f ${DESTDIR}${XSESSIONS}/dwm.desktop

.PHONY: all options clean scripts dist install uninstall
