include secret.mk

PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LANG=enfr fren fres esfr

FILES=backupusb m mkmime.py unmime.py smartmail mime_alternative.py \
	lum temp ripdvd translate.fish \
	sway_bar sway_menu sway_screensaver \
	ydl video videocat videotomp4 ripdvd2 typo evoke colortil gcard \
	installfont

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
	@sed -e "s/@inbox@/$(inbox)/g; \
		s/@fanuilas@/$(fanuilas)/g; \
		s/@laposte@/$(laposte)/g; \
		s/@scic@/$(scic)/g; \
		s/@csmjc@/$(csmjc)/g" $< > $@
