COLORSCHEME=color/selenized.fish
COLORIZE=termite/config sway/color vis/themes/mine.lua fish/color.fish
CONFDIR=fish/config.fish fish/completions/mpc.fish\
	khal/config \
	khard/khard.conf \
	mpd/mpd.conf \
	mpv/mpv.conf \
	sway/color sway/config \
	termite/config termite/termite.terminfo \
	vdirsyncer/config \
	vis/visrc.lua vis/themes/mine.lua

HOMEDIR=vimrc \
	vim/colors/dracula.vim vim/colors/selenized.vim \
	vim/colors/blue.vim vim/colors/troff.vim \
	vim/syntax/bnk.vim vim/syntax/csv.vim vim/syntax/fish.vim \
	vim/syntax/map.vim vim/syntax/pacman.vim vim/syntax/tag.vim \
	vim/syntax/tintin.vim vim/syntax/troff.vim vim/syntax/txt2tags.vim

include secret.mk

install: $(COLORIZE) $(CONFDIR:%=$(HOME)/.config/%) $(HOMEDIR:%=$(HOME)/.%)

clean:
	rm -f $(COLORIZE)

$(COLORIZE): %: %.tmp color/colorize.fish $(COLORSCHEME) makefile
	@echo "Creating $@"
	@fish color/colorize.fish $(COLORSCHEME) < $< > $@
	@#if test "$@" = "fish/color.fish"; then echo "Coloring fish session."; fish fish/color.fish; fi

$(HOME)/.config/%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	@sed -e "s/@email@/$(email)/g; s,@bnbcal@,$(bnbcal),g" $< > $@

$(HOME)/.%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	@cp $< $@
