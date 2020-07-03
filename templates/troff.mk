# Formatting text with Neatroff

# Default macro
TMAC=-mul -mu-fr
#TMAC=-muh -mu-apolline -mu-fr

# Prefix directory
PREFIX=$(HOME)/.local
# Where to find neatroff and utroff binaries 
BINDIR=$(PREFIX)/bin
# Where to find neatroff libraries
LIBDIR=$(PREFIX)/share
# Where to find troffxml xsl stylesheet
XSLDIR=$(LIBDIR)/xslt
# Where to find utmac macros
MACDIR=$(LIBDIR)/tmac
# Where to find troff fonts
FNTDIR=$(LIBDIR)/font
# Where to find OTF fonts
OTFDIR=/usr/share/fonts/OTF:/usr/share/fonts/ttf-linux-libertine/

# Neatroff tools
ROFF=$(BINDIR)/roff
PDF=$(BINDIR)/pdf
POST=$(BINDIR)/post
TBL=$(BINDIR)/tbl
EQN=$(BINDIR)/eqn
# Utroff tools
REFER=$(BINDIR)/refer
UGRIND=$(BINDIR)/ugrind
PREXML=$(BINDIR)/prexml
POSTXML=$(BINDIR)/postxml
TCHARS=$(BINDIR)/tchars
TSQL=$(BINDIR)/tsql
TPLAN=$(BINDIR)/tplan

# Groff tools
NROFF=groff -k -Tutf8 -M$(MACDIR)
SOELIM=soelim


# ps2pdf setting
FONTS=$(FNTDIR)/:$(OTFDIR)/
PDFFLAGS1=-q -dPDFSETTINGS=/prepress -dEmbedAllFonts=true \
		  -sFONTPATH=$(FONTS)
PDFFLAGS2=-dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
		  -sProcessColorModel=DeviceGray
PDFCRYPT=-sOwnerPassword="`dd if=/dev/random bs=12 count=1 2>/dev/null \
		| md5sum | awk '{ print $$1 }'` " -dEncryptionR=3 \
		-dKeyLength=128 -dPermissions=-300

LAST=$(shell ls -t *.tr | head -1 | sed -e "s/\.tr//")

ALL=$(shell ls -t *.tr | sed -e "s/\.tr//")

last: $(LAST).pdf

vi:
	vim $(LAST).tr

spell:
	aspell -n check $(LAST).tr

mu: $(LAST).pdf
	mupdf $<


help:
	@echo "set REFARG=\"-p file.ref\""
	@echo "set TMAC=-mul -mu-fr -mu-tbl -mu-ref"
	@echo "make last vi mu .ps .pdf .n.pdf .c.pdf .crypt.pdf"
	@echo "make .txt .mkd .man .xml .html .fodt"


%.tmp: %.tr
	@echo "Generating $@"
	@$(SOELIM) $< | $(UGRIND) | $(TPLAN) | $(REFER) -a -b -dAE $(REFARG) > $@

%.to: %.tmp
	@echo "Generating $@ with $(TMAC)"
	@$(ROFF) $(TMAC) $< > /dev/null 2>&1 
	@$(ROFF) $(TMAC) $< > /dev/null 2>&1
	@$(ROFF) $(TMAC) $< > $@

%.ps: %.to
	@echo "Generating $@"
	@$(POST) -pa4 < $< > $@

%.ps.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf $(PDFFLAGS1) $< $@

%.n.pdf: %.tmp
	@echo "Generating $@"
	@$(PDF) -pa4 <$< > $@

%.pdf: %.ps.pdf
	@mv $< $@

%.c.pdf: %.pdf
	@echo "Compressing $<"
	@#mutool convert -o $@ -O compress,compress-fonts $<
	@gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
	-dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH \
	-sOutputFile=$@ $<


%.crypt.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf $(PDFFLAGS1) $(CRYPT) $< $@

%.clean.pdf: %.pdf
	@echo "Cleaning $<"
	@mutool clean -g -g -g -s -d $< $@

%.txt: %.tmp
	@echo "Generating $@"
	@$(NROFF) -mut $< > $@

%.mkd: %.tmp
	@echo "Generating $@"
	@$(NROFF) -muw $< > $@

%.man: %.tr
	@echo "Generating $@"
	@$(SOELIM) $< | $(UGRIND) | $(NROFF) -mum > $@

%.xml: %.tmp
	@echo "Generating $@"
	@$(PREXML) < $< | $(UGRIND) | $(NROFF) -mux | $(POSTXML) > $@

%.html: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utohtml.xsl $< > $@

%.fodt: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utofodt.xsl $< > $@

%.doc: %.fodt
	@echo "Generating $@"
	@unoconv -f doc $<

clean:
	@rm -f *.ig $(ALL:%=%.tmp) $(ALL:%=%.to) $(ALL:%=%.ps) $(ALL:%=%.ps.pdf) \
	$(ALL:%=%.pdf) $(ALL:%=%.n.pdf) $(ALL:%=%.c.pdf) $(ALL:%=%.crypt.pdf) \
	$(ALL:%=%.txt) $(ALL:%=%.mkd) $(ALL:%=%.man) $(ALL:%=%.xml) $(ALL:%=%.html) \
	$(ALL:%=%.fodt)
