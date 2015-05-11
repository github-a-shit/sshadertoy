# sshadertoy - simple shadertoy viewer for X & GLES2.
# See LICENSE file for copyright and license details.

include config.mk

SRC = sshadertoy.c
OBJ = ${SRC:.c=.o}

all: options sshadertoy

options:
	@echo sshadertoy build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

sshadertoy: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f sshadertoy ${OBJ} sshadertoy-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p sshadertoy-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk ${SRC} sshadertoy-${VERSION}
	@tar -cf sshadertoy-${VERSION}.tar sshadertoy-${VERSION}
	@gzip sshadertoy-${VERSION}.tar
	@rm -rf sshadertoy-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f sshadertoy ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/sshadertoy
	@chmod u+s ${DESTDIR}${PREFIX}/bin/sshadertoy

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/sshadertoy

.PHONY: all options clean dist install uninstall
