# Prefix directory
PREFIX=$(HOME)/.local
# Where to find neatroff and utroff binaries 
BINDIR=$(PREFIX)/bin
# Where to find neatroff libraries
LIBDIR=$(PREFIX)/share
# Where to install man files
MANDIR=$(LIBDIR)/man

ALL=github gitinit gitfork pacman smart power_save ezmlm

all: $(ALL:%=%.man)

install: $(ALL:%=$(MANDIR)/man7/%.7)

$(MANDIR)/man7/%.7: %.man
	test -d $(MANDIR)/man7 || mkdir -p $(MANDIR)/man7
	install -c -m 644 $< $@

include include.mk
