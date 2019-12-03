# tary, 15:18 2018/12/20
#
SHELL = /bin/sh

.SUFFIXES: .c .o

prefix ?= ./usr/local

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
RM = rm -f

# Get source files directory
# To separate build & source directory
srcdir := $(dir $(firstword ${MAKEFILE_LIST}))
srcdir := $(shell cd ${srcdir}; pwd)

TGT_BOOTSCR   = boot.scr.uimg

TARGETS = $(TGT_BOOTSCR)


# $(warning srcdir=$(srcdir))
VPATH = $(srcdir)/src

all: # $(TARGETS) $(LIBS)

$(TGT_BOOTSCR):
	# nothing
	#
	# mkimage -C none -A arm -T script -d $< $@
	#
	# # the reverse:
	# dumpimage -i root/boot/boot.scr.uimg -T script -p 0 boot.scr.data
	# # Remove data-header
	# dd if=boot.scr.data of=boot.cmd bs=8 skip=1

install: all
	# $(INSTALL) -d $(DESTDIR)/boot/
	# cp -rf boot $(DESTDIR)/
	# $(INSTALL) -D $(TGT_BOOTSCR) $(DESTDIR)/boot/
	cp -rf root/* $(DESTDIR)/

uninstall:
	# -$(RM) $(DESTDIR)/boot/$(TGT_BOOTSCR)
	-$(RM) $(DESTDIR)/lib/firmware/brcm/*.hcd

clean:
	-$(RM) *.o $(TARGETS)

.PHONY: all clean install uninstall

