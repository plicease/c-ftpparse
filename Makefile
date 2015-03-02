INSTALL_TO=~/opt/ftpparse

#
OBJ=case_lwrtab.o case_startb.o ftpparse.o tai_now.o tai_uint.o utcdate2tai.o
HEADERS=bailout.h case.h str.h typesize.h utcdate2tai.h buffer.h ftpparse.h tai.h uint64.h auto-typesize.h
CC=clang
LD=clang
CFLAGS=-I. -fPIC -Wall
RM=rm -f
PERL=perl
LIBNAME=libftpparse
AR=ar
RANLIB=ranlib
INSTALL=install

all : $(LIBNAME).a $(LIBNAME).so

install : $(LIBNAME).a $(LIBNAME).so auto-typesize.h
	$(INSTALL) -d $(INSTALL_TO)/lib
	$(INSTALL) -m 644 $(LIBNAME).a $(INSTALL_TO)/lib/$(LIBNAME).a
	$(INSTALL) -m 755 $(LIBNAME).so $(INSTALL_TO)/lib/$(LIBNAME).so
	$(INSTALL) -d $(INSTALL_TO)/include
	$(INSTALL) -m 644 $(HEADERS) $(INSTALL_TO)/include/

$(LIBNAME).so : $(OBJ)
	$(LD) -shared $(LDFLAGS) $(CFLAGS) -o $(LIBNAME).so $(OBJ)

$(LIBNAME).a : $(OBJ)
	$(AR) rc $(LIBNAME).a $(OBJ)
	$(RANLIB) $(LIBNAME).a

auto-typesize.h : typesize.pl
	$(PERL) typesize.pl

clean :
	$(RM) $(OBJ) auto-typesize.h $(LIBNAME).a $(LIBNAME).so

%.o : %.c $(HEADERS)
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
