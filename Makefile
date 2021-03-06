# xmsg
# See LICENSE file for copyright and license details.

include config.mk

SRC = main.cpp aes.c base64.cpp keychain.cpp xmsg.cpp argparser.cpp
OBJ = ${SRC:.cpp=.o}
OBJ := ${OBJ:.c=.o}

all: options xmsg

options:
	@echo xmsg build options:
	@echo "CFLAGS	= ${CFLAGS}"
	@echo "LDFLAGS	= ${LDFLAGS}"
	@echo "CC	= ${CC}"
	@echo "OBJ	= ${OBJ}"
	@echo "CONFIG	= ${CONFIG}"

.c.o:
	@echo CC -c $<
	@${CC} -c ${CFLAGS} $<
.cpp.o:
	@echo CC -c $<
	@${CC} -c ${CFLAGS} $<

config.hpp:
	@echo copying config.def.hpp into config.hpp
	@cp -f ./config.def.hpp ./config.hpp

xmsg: config.hpp ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f xmsg config.hpp ${OBJ}

install: all
	@echo installing executable file to ${PREFIX}/bin
	@mkdir -p ${PREFIX}/bin
	@cp -f xmsg ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/xmsg
	@chmod u+s ${PREFIX}/bin/xmsg

uninstall:
	@echo removing executable file from ${PREFIX}/bin
	@rm -f ${PREFIX}/bin/xmsg

