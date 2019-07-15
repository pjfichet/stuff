
PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LANG=enfr fren

FILES=statusbar backupusb m mimer.py smartmail \
	lum menubar temp ripdvd translate.fish \
	ydl typo

ALL=$(FILES:%=$(BINDIR)/%) $(LANG:%=$(BINDIR)/%)

help:
	make install uninstall

install: $(ALL)

uninstall:
	-rm $(ALL)

$(BINDIR):
	mkdir -r $@

$(LANG:%=$(BINDIR)/%): $(BINDIR)/translate.fish
	cd $(BINDIR) && ln -s translate.fish $(@F)

$(BINDIR)/%: %
	install -c -m 755 $< $@

