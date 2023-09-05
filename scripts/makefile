include secret.mk

COLORSCHEME=violet.fish
PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LANG=enfr fren fres esfr

COLORIZE=sway_menu

FILES=backupusb translate.fish installfont typo gcard \
	temp sway_bar sway_menu sway_screensaver \
	ydl video videocat videotomp4 ripdvd ripdvd2  \
	omw evoke colortil 

OLDFILES=m mkmime.py unmime.py smartmail mime_alternative.py \
	
ALL=$(FILES:%=$(BINDIR)/%) $(LANG:%=$(BINDIR)/%)

$(COLORIZE): %: %.tmp ../dotfiles/color/colorize.fish ../dotfiles/color/$(COLORSCHEME) makefile
	@echo "Creating $@"
	@fish ../dotfiles/color/colorize.fish ../dotfiles/color/$(COLORSCHEME) < $< > $@

colorfiles: $(COLORIZE)


help:
	make install uninstall

clean:
	rm $(COLORIZE)

install: $(ALL)

uninstall:
	-rm -f $(ALL) $(OLDFILES:%=$(BINDIR)/%)

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
