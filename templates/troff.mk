# Formatting text with Neatroff

# Default macro
TMAC=-mul -mu-fr
#TMAC=-muh -mu-apolline
LMAC=-mu-fr

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
PIC=$(BINDIR)/pic
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

lastpdf: $(LAST).pdf

last:
	@echo $(LAST).tr

vi:
	@$$EDITOR $(LAST).tr

spell:
	aspell -n check $(LAST).tr

mu: $(LAST).pdf
	mupdf $<

help:
	@echo "edit local makefile:"
	@echo "    include $(XDG_TEMPLATES_DIR)/troff.mk"
	@echo "    TMAC=-mul -mu-tbl -mu-ref"
	@echo "    LMAC=-mufr"
	@echo "    REFARG=\"-p file.ref\""
	@echo "make last vi mu .ps .ps.pdf .n.pdf .pdf .crypt.pdf"
	@echo "make .txt .mkd .man .xml .html .fodt .doc"
	@echo "make .book.pdf"

%.tmp: %.tr
	@echo "Generating $@"
	@$(SOELIM) $< | $(UGRIND) | $(PIC) | $(REFER) -a -b -dAE $(REFARG) > $@
	#@$(SOELIM) $< > $@

%.to: %.tmp
	@echo "Generating $@ with $(TMAC) $(LMAC)"
	@$(ROFF) $(TMAC) $(LMAC) $< > /dev/null 2>&1 
	@$(ROFF) $(TMAC) $(LMAC) $< > /dev/null 2>&1
	@$(ROFF) $(TMAC) $(LMAC) $< > $@

%.ps: %.to
	@echo "Generating $@"
	@$(POST) -pa4 < $< > $@

%.ps.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf $(PDFFLAGS1) $< $@

#%.pdf: %.ps.pdf
#	@mv $< $@

%.n.pdf: %.tr
	@echo "Generating $@"
	@$(ROFF) $(TMAC) $(LMAC) $< | $(PDF) -pa4 > $@

%.pdf: %.n.pdf
	@echo "Generating compressed $@"
	@mutool convert -o $@ -O compress,compress-fonts,compress-images $<

#%.pdf: %.n.pdf
#@echo "Compressing $<"
#@gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
#-dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH \
#-sOutputFile=$@ $<


%.crypt.pdf: %.ps
	@echo "Generating $@"
	@ps2pdf $(PDFFLAGS1) $(CRYPT) $< $@

%.clean.pdf: %.pdf
	@echo "Cleaning $<"
	@mutool clean -g -g -g -s -d $< $@

%.txt: %.tmp
	@echo "Generating $@"
	@$(NROFF) -mut $(LMAC) $< > $@

%.mkd: %.tmp
	@echo "Generating $@"
	@$(NROFF) -muw $(LMAC) $< > $@

%.man: %.tr
	@echo "Generating $@"
	@$(SOELIM) $< | $(UGRIND) | $(NROFF) -mum $(LMAC) > $@

%.xml: %.tmp
	@echo "Generating $@"
	@$(PREXML) < $< | $(UGRIND) | $(NROFF) -mux $(LMAC) | $(POSTXML) > $@

%.html: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utohtml.xsl $< > $@

%.fodt: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utofodt.xsl $< > $@

%.doc: %.fodt
	@echo "Generating $@"
	@unoconv -f doc $<

%-book.pdf: %.pdf
	@#psbook -s8 a.ps b.ps
	@echo "Generating $@"
	@pdf2ps $< /tmp/a.ps
	@psnup -2 /tmp/a.ps /tmp/b.ps
	@ps2pdf -sPAPERSIZE=a4 /tmp/b.ps $@
	@rm -f /tmp/a.ps /tmp/b.ps

clean:
	@rm -f *.ig $(ALL:%=%.tmp) $(ALL:%=%.to) $(ALL:%=%.ps) $(ALL:%=%.ps.pdf)
	@rm -f $(ALL:%=%.pdf) $(ALL:%=%.n.pdf) $(ALL:%=%.c.pdf) $(ALL:%=%.crypt.pdf)
	@rm -f $(ALL:%=%.txt) $(ALL:%=%.mkd) $(ALL:%=%.man) $(ALL:%=%.xml) $(ALL:%=%.html) \
	$(ALL:%=%.fodt) $(ALL:%=%.doc) $(ALL:%=%-book.pdf)
