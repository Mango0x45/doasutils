PREFIX    = /usr/local
DPREFIX   = ${DESTDIR}${PREFIX}
MANDIR    = ${DPREFIX}/share/man
DOAS_CONF = /etc/doas.conf

all:

install:
	mkdir -p ${DPREFIX}/bin ${MANDIR}/man7 ${MANDIR}/man8
	cp doasutils.7 ${MANDIR}/man7
	cp doasedit ${DPREFIX}/bin
	cp doasedit.8 ${MANDIR}/man8
	sed 's|@DOAS_CONF@|${DOAS_CONF}|g' vidoas   >${DPREFIX}/bin/vidoas
	sed 's|@DOAS_CONF@|${DOAS_CONF}|g' vidoas.8 >${MANDIR}/man8/vidoas.8
	chmod +x ${DPREFIX}/bin/vidoas
