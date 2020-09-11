Convert postscript (ps) to pdf:

%.ps: %.pdf
	@echo "Generating $@"
	@gs -q -dBATCH -dNOPAUSE -sDEVICE=ps2write -sOutputFile=$@ $<

%.pdf: %.ps
	@echo "Generating $@"
	@gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$@ $<

#Merge ps and/or pdf:
#	gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
#	-sOutputFile=fileout.pdf filein1.ps filein2.pdf filein3.pdf

#Extract page(s) from a ps or a pdf document:
#	gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
#	-dFirstPage=3 -dLastPage=3 -sOutputFile=fileout.pdf filein.ps

#Embed fonts in a pdf:
#	gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=fileout.pdf \
#	-dPDFSETTINGS=/prepress -dEmbedAllFonts=true -dSubsetFonts=true \
#	-dCompatibilityLevel=1.6 filein.pdf

#Convert images to pdf:
# https://stackoverflow.com/questions/4283245/using-ghostscript-to-convert-jpeg-to-pdf
#	gs -sDEVICE=pdfwrite -o foo.pdf \
#	/usr/local/share/ghostscript/8.71/lib/viewjpeg.ps \
# 	-c "(my.jpg) viewJPEG"

#PDF optimization options
#	-dPDFSETTINGS=/screen (screen-view-only quality, 72 dpi images)
#	-dPDFSETTINGS=/ebook (low quality, 150 dpi images)
#	-dPDFSETTINGS=/printer (high quality, 300 dpi images)
#	-dPDFSETTINGS=/prepress (high quality, color preserving, 300 dpi imgs)
#	-dPDFSETTINGS=/default (almost identical to /screen)

#Paper size options
#	-sPAPERSIZE=letter
#	-sPAPERSIZE=a4
#	-dDEVICEWIDTHPOINTS=w -dDEVICEHEIGHTPOINTS=h (point=1/72 of an inch)
#	-dFIXEDMEDIA (force paper size over the PostScript defined size)
#	-gWIDTHxHEIGHT  (page size in pixels)

#Output devices:
#	-sDEVICE=pdfwrite
#	-sDEVICE=ps2write
#	-sDEVICE=png16m  (24-bit RGB color)
#	-sDEVICE=pnggray  (grayscale)
#	-sDEVICE=pngmono  (black-and-white)
#	-sDEVICE=pngalpha (32-bit RGBA color)
#	-sDEVICE=jpeg   (color JPEG)
#	-sDEVICE=jpeggray  (grayscale JPEG)
#	-sDEVICE=epswrite  (encapsulated postscript)
#	-sDEVICE=txtwrite  (text output, UTF-8)

#Help & list of available devices:
#	gs -h

#Other options
#	-dNOPAUSE    (no pause after page)
#	-dBATCH  (exit after last file)
#	-sOutputFile=ABC-%03d.pgm (produces 'ABC-001.pgm'..'ABC-010.pgm'..)
#	-dEmbedAllFonts=true
#	-dSubsetFonts=true  (Embeds only the characters used in document)
#	-dCompatibilityLevel=1.4  (Adobe's PDF specifications,
#		>=1.4 for font embedding, 
#		=1.6 for OpenType font embedding)
#	-dCompressPages=true  (compress page content)
#	-dFirstPage=pagenumber
#	-dLastPage=pagenumber
#	-dAutoRotatePages=/PageByPage  (or /All or /None)
#	-rXRESxYRES (XRES & YRES in pixels/inch)
#	-rRES (same XRES & YRES, affects images and fonts converted to bitmaps)
#	-sPDFPassword=password
