COLORSCHEME=color/darkone.fish
COLORIZE=termite/config sway/color vis/themes/mine.lua
CONFDIR=fish/config.fish \
	khal/config \
	khard/khard.conf \
	mpd/mpd.conf \
	mpv/mpv.conf \
	sway/color sway/config \
	termite/config termite/termite.terminfo \
	vdirsyncer/config \
	vis/visrc.lua vis/themes/mine.lua

HOMEDIR=vimrc \
	vim/colors/blue.vim vim/colors/troff.vim \
	vim/syntax/bnk.vim vim/syntax/csv.vim vim/syntax/fish.vim \
	vim/syntax/map.vim vim/syntax/pacman.vim vim/syntax/tag.vim \
	vim/syntax/tintin.vim vim/syntax/troff.vim vim/syntax/txt2tags.vim

include secret.mk

install: $(COLORIZE) $(CONFDIR:%=$(HOME)/.config/%) $(HOMEDIR:%=$(HOME)/.%)

clean:
	rm -f $(COLORIZE)

$(COLORIZE): %: %.tmp color/colorize.fish $(COLORSCHEME)
	fish color/colorize.fish $(COLORSCHEME) < $< > $@

$(HOME)/.config/%: %
	test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	sed -e "s/@email@/$(email)/g; s,@bnbcal@,$(bnbcal),g" $< > $@

$(HOME)/.%: %
	test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	cp $< $@
