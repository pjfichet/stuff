COLORSCHEME=color/violet.fish
COLORIZE=termite/config \
	sway/color \
	vis/themes/mine.lua \
	fish/color.fish \
	helix/themes/my-theme.toml \
	mako/config \
	alacritty/alacritty.toml \
	vimrc \
	dunst/dunstrc

CONFDIR=fish/config.fish fish/completions/mpc.fish\
	khal/config \
	khard/khard.conf \
	mpd/mpd.conf \
	mpv/mpv.conf \
	sway/color sway/config \
	mako/config \
	vdirsyncer/config \
	vis/visrc.lua vis/themes/mine.lua \
	vis/lexers/mail.lua vis/lexers/pacman.lua \
	vis/lexers/tintin.lua vis/lexers/troff.lua \
	helix/config.toml helix/themes/my-theme.toml \
	alacritty/alacritty.toml \
	dunst/dunstrc \
	imv/config \
	bt/devices

OLDCONFDIR=termite/config termite/termite.terminfo

HOMEDIR=vimrc \
	vim/colors/selenized.vim \
	vim/colors/blue.vim vim/colors/troff.vim \
	vim/syntax/bnk.vim vim/syntax/csv.vim vim/syntax/fish.vim \
	vim/syntax/map.vim vim/syntax/pacman.vim vim/syntax/tag.vim \
	vim/syntax/tintin.vim vim/syntax/troff.vim vim/syntax/txt2tags.vim

SHAREDIR=tmac/pj.tmac

VIMPLUGINS=lightline zig

include secret.mk

install: $(COLORIZE) $(CONFDIR:%=$(HOME)/.config/%) $(HOMEDIR:%=$(HOME)/.%) \
	$(SHAREDIR:%=$(HOME)/.local/share/%)

update: $(VIMPLUGINS:%=$(HOME)/.vim/pack/plugins/start/%)

clean:
	rm -f $(COLORIZE)

uninstall:
	rm -f $(CONFDIR:%=$(HOME)/.config/%)
	rm -f $(OLDCONFDIR:%=$(HOME)/.config/%)
	rm -f $(HOMEDIR:%=$(HOME)/.%)

$(COLORIZE): %: %.tmp color/colorize.fish $(COLORSCHEME) makefile
	@echo "Creating $@"
	@fish color/colorize.fish $(COLORSCHEME) < $< > $@
	@#if test "$@" = "fish/color.fish"; then echo "Coloring fish session."; fish fish/color.fish; fi

colorfiles: $(COLORIZE)

$(HOME)/.config/%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	@sed -e "s/@email@/$(email)/g; s/@user@/$(user)/g" $< > $@

$(HOME)/.local/share/%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	cp $< $@

$(HOME)/.%: %
	@echo "Installing $@"
	@test -d $$(dirname $@) || mkdir -p $$(dirname $@)
	@cp $< $@

$(VIMPLUGINS:%=$(HOME)/.vim/pack/plugins/start/%):
	@echo $@
	@test -e $@ && cd $@ && git pull || true
	@test ! -e $@ && git clone https://github.com/itchyny/$$(basename $@).vim $@ || true

.PHONY: $(VIMPLUGINS:%=$(HOME)/.vim/pack/plugins/start/%)

