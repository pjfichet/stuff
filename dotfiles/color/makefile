THEME=darkone.mk
include $(THEME)

CONFDIR=$(HOME)/.config


ALL=config-vis.lua config-termite.conf config-sway.conf
all: $(ALL)

config-%: config/% makefile $(THEME)
	@echo "Building $@."
	@sed -e "s/#background1/#$(background1)/g; \
	s/#background2/#$(background2)/g; \
	s/#foreground1/#$(foreground1)/g; \
	s/#foreground2/#$(foreground2)/g; \
	s/#foreground3/#$(foreground3)/g; \
	s/#red/#$(red)/g; \
	s/#green/#$(green)/g; \
	s/#yellow/#$(yellow)/g; \
	s/#blue/#$(blue)/g; \
	s/#magenta/#$(magenta)/g; \
	s/#cyan/#$(cyan)/g; \
	s/#light_red/#$(light_red)/g; \
	s/#light_green/#$(dark_green)/g; \
	s/#light_yellow/#$(light_yellow)/g; \
	s/#light_blue/#$(light_blue)/g; \
	s/#light_magenta/#$(light_magenta)/g; \
	s/#light_cyan/#$(light_cyan)/g; \
	" $< > $@

install: $(ALL)
	cp config-vis.lua $(CONFDIR)/vis/themes/mine.lua
	cp config-termite.conf $(CONFDIR)/termite/config
	cp config-sway.conf $(CONFDIR)/sway/color

clean:
	rm $(ALL)


solarized:
	cp termite-solarized.conf $(CONFDIR)/termite/config
	cp vis-solarized.lua $(CONFDIR)/vis/themes/solarized.lua
	cp sway-color $(CONFIDR)/sway/color

