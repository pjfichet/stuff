PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
NEAT=pop3 smtp neatmail

all = pop3/pop3 smtp/smtp neatmail/neatmail

$(NEAT):
	git clone git://repo.or.cz/$@.git

$(BINDIR):
	mkdir -p $@

pop3/pop3: pop3
	@echo "Building pop3"
	@cd pop3 && git apply ../diff/pop3.diff
	@cd pop3 && $(MAKE)
	@install -c pop3/pop3 $(BINDIR)/pop3

smtp/smtp: smtp
	@echo "Building smtp"
	@cd smtp && git apply ../diff/smtp.diff
	@cd smtp && $(MAKE)
	@install -c smtp/smtp $(BINDIR)/smtp

$(BINDIR)/%: % %/%
	@echo "Installing $(BINDIR)/$<"
	@test -e $(BINDIR) || mkdir -p $(BINDIR)
	@install -c $< $(BINDIR)/$<

install: $(BINDIR)/pop3 $(BINDIR)/smtp $(BINDIR)/neatmail

uninstall:
	rm -f $(BINDIR)/pop3 $(BINDIR)/smtp $(BINDIR)/neatmail
	

clean:
	rm -rf $(NEAT)

.PHONY: all install uninstall clean
