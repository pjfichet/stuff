include secret.mk

PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LANG=enfr fren fres esfr

FILES=statusbar backupusb m mkmime.py unmime.py smartmail \
	lum menubar temp ripdvd translate.fish \
	sway_screensaver \
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

m: m.fish
	@echo "Creating m."
	@sed -e "s/@inbox@/$(inbox)/g; s/@scic@/$(scic)/g" $< > $@
