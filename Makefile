ROOT ?=
DEFUSRBIN ?= /usr/bin/
DEFSBIN ?= /sbin/
MANDIR ?= /usr/share/man/
STATIC_LIBDIR ?= /usr/lib/
CC ?= gcc
AR ?= ar
INSTALL ?= /bin/install
LDFLAGS ?= -static

all: libssp-nonshared getconf getent iconv

getconf: getconf.o
	$(LD) $(LDFLAGS) getconf.o -o getconf 

getconf.o: cmd/getconf.c 
	$(CC) $(CFLAGS) $(CPPFLAGS) -c ./cmd/getconf.c 

getent: getent.o
	$(LD) $(LDFLAGS) getent.o -o getent

getent.o: cmd/getent.c 
	$(CC) $(CFLAGS) $(CPPFLAGS) -c ./cmd/getent.c

iconv: iconv.o
	$(LD) $(LDFLAGS) iconv.o -o iconv

iconv.o: cmd/iconv.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c ./cmd/iconv.c

libssp-nonshared: __stack_chk_fail_local.o
	$(AR) r libssp_nonshared.a ./__stack_chk_fail_local.o

__stack_chk_fail_local.o: lib/__stack_chk_fail_local.c
	$(CC) -fpie -c ./lib/__stack_chk_fail_local.c -o __stack_chk_fail_local.o

install: install-libssp install-progs 

install-progs: getconf getent iconv cmd/ldconfig
	for program in getconf getent iconv ; do \
	        $(INSTALL) -c -m 755 $$program $(ROOT)$(DEFUSRBIN) ; \
		$(INSTALL) -c -m 644 ./man/$$program.1 $(ROOT)$(MANDIR) ; \
	done
	$(INSTALL) -c -m 755 cmd/ldconfig $(ROOT)$(DEFSBIN)

install-libssp: libssp_nonshared
	$(INSTALL) -c -m 664 ./libssp_nonshared.a $(ROOT)$(STATIC_LIBDIR)

clean:
	rm -f *.o *.a getconf getent iconv *~
