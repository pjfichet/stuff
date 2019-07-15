TPLDIR=$(XDG_TEMPLATES_DIR)

ALL=troff.mk

install: $(ALL:%=$(TPLDIR)/%)

$(TPLDIR)/%: %
	install -c -m 644 $< $@
