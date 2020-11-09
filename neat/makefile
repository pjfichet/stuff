PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/share
FNTDIR=$(LIBDIR)/font
TTFDIR=$(FNTDIR)/ttf
MACDIR=$(LIBDIR)/tmac
HYPDIR=$(LIBDIR)/hyph
ALLDIR=$(BINDIR) $(LIBDIR) $(DEVDIR) $(FNTDIR) $(MACDIR) $(HYPDIR)

NEAT = pop3 smtp neatmail 

$(NEAT):
	git clone git://repo.or.cz/$@.git

$(ALLDIR):
	mkdir -p $@

dirs: $(ALLDIR)

mkfn:
	cd neatmkfn && $(MAKE)
	install -c neatmkfn/mkfn $(BINDIR)/mkfn

font: mkfn
	cd makefont && $(MAKE) FNTDIR=$(FNTDIR) HYPDIR=$(HYPDIR)

mail: pop3 smtp
	@echo "Building pop3"
	@cd pop3 && git apply ../diff/pop3.diff
	@cd pop3 && $(MAKE)
	@install -c pop3/pop3 $(BINDIR)/pop3
	@echo "Building smtp"
	@cd pop3 && git apply ../diff/smtp.diff
	@cd pop3 && $(MAKE)
	@install -c smtp/smtp $(BINDIR)/smtp

clean:
	rm -rf $(NEAT)

.PHONY:
