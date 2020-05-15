
PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LANG=enfr fren

FILES=statusbar backupusb m mkmime.py unmime.py smartmail \
	lum menubar temp ripdvd translate.fish \
	ydl typo evoke colortil gcard

ALL=$(FILES:%=$(BINDIR)/%) $(LANG:%=$(BINDIR)/%)

help:
	make install uninstall

install: $(ALL)

uninstall:
	-rm $(ALL)

$(BINDIR):
	mkdir -p $@

$(LANG:%=$(BINDIR)/%): $(BINDIR)/translate.fish
	cd $(BINDIR) && ln -s translate.fish $(@F)

$(BINDIR)/%: % | $(BINDIR)
	install -m 755 $< $@

