# fish configuration

set -x PATH $PATH $HOME/.local/bin
set -x HOSTNAME (cat /proc/sys/kernel/hostname)
set -x TERM xterm-256color
set -x EDITOR vis
set -x LESSCHARSET utf-8
set -x G_FILENAME_ENCODING @locale,UTF-8
set -x LC_ALL fr_FR.UTF-8
#set -x MANWIDTH 65
set -x MANDIR $HOME/.local/share/man
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_DESKTOP_DIR $HOME
set -x XDG_DOCUMENTS_DIR $HOME/doc
set -x XDG_TEMPLATES_DIR $XDG_DOCUMENTS_DIR/tpl
set -x XDG_MEDIAS_DIR $HOME/doc
set -x XDG_MUSIC_DIR $XDG_MEDIAS_DIR/mus
set -x XDG_PICTURES_DIR $XDG_MEDIAS_DIR/pic
set -x XDG_PUBLICSHARE_DIR $XDG_MEDIAS_DIR/pub
set -x XDG_VIDEOS_DIR $XDG_MEDIAS_DIR/vid
set -x XDG_SRC_DIR $XDG_MEDIAS_DIR/src
set -x XDG_DOWNLOAD_DIR $HOME/dld
#set -x XDG_DATA_DIRS "/usr/local/share:/usr/share"
#set -x XDG_CONFIG_DIRS "/etc/xdg"
#set -x XDG_CONFIG_DIRS "/etc/xdg:$XDG_CONFIG_DIRS"
#set -x XDG_RUNTIME_DIR
set -x CDPATH .:~:$XDG_DOCUMENTS_DIR
if test "$HOSTNAME" = "t480"
	set -x XKB_DEFAULT_MODEL thinkpad
	set -x XKB_DEFAULT_LAYOUT fr
	set -x XKB_DEFAULT_VARIANT oss
else
	set -x XKB_DEFAULT_MODEL pc101
	set -x XKB_DEFAULT_LAYOUT fr,fr
	set -x XKB_DEFAULT_VARIANT oss,bepo
	set -x XKB_DEFAULT_OPTIONS grp:alt_shift_toggle
	set -x XKB_DEFAULT_OPTIONS grp:shifts_toggle
end
set -x PASSWORD_STORE_DIR $XDG_DOCUMENTS_DIR/pass
set -x PASSWORD_STORE_CHARACTER_SET '[:alnum:],?*%~./'
set -x VCARD_DIR $XDG_DOCUMENTS_DIR/dav/card/
set -x XAPPS firefox libreoffice gimp gcompris-qt inkscape omw klavaro
set -x OPENMW_PHYSICS_FPS 30
set -x PHONE_CARD storage/7FDD-280D
set -x PHONE_CAM sdcard/DCIM/Camera
#set -x EXINIT "/etc/vi.my"
set -x BUP_DIR $XDG_CACHE_HOME/bup
set -x SAL_USE_VCLPLUGIN gtk3
set -x QT_QPA_PLATFORM wayland
set -x CLUTTER_BACKEND wayland
set -x SDL_VIDEODRIVER wayland
set -x GDK_BACKEND "wayland"
#set -x MOZ_ENABLE_WAYLAND 1 firefox

  #termcap terminfo
  #ks      smkx      make the keypad send commands
  #ke      rmkx      make the keypad send digits
  #vb      flash     emit visual bell
  #mb      blink     start blink
  #md      bold      start bold
  #me      sgr0      turn off bold, blink and underline
  #so      smso      start standout (reverse video)
  #se      rmso      stop standout
  #us      smul      start underline
  #ue      rmul      stop underline
set -x LESS_TERMCAP_mb (set_color brblue)
set -x LESS_TERMCAP_md (set_color brblue)
set -x LESS_TERMCAP_me (set_color normal)
set -x LESS_TERMCAP_se (set_color normal)
set -x LESS_TERMCAP_so (set_color -b black)
set -x LESS_TERMCAP_ue (set_color normal)
set -x LESS_TERMCAP_us (set_color green)
#set LS_COLORS 'rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';


alias ls "ls --color=auto --group-directories-first"
alias gcompris "gcompris-qt"
alias diff "diff -u"
alias perms "stat -c '%A %a %n'"
alias datetime "date +'%A %d %B %Y, %H:%M'"
alias dater "date +%Y%m%d"
alias sway "/usr/bin/sway 2> sway.log"
alias wclip "swaymsg clipboard"
alias davsync "vdirsyncer sync"
alias vi "vim"
alias fox "firefox"
alias pmount "udevil mount"
alias pumount "udevil umount"
alias play "alsaplayer -i text"
alias pnext "alsaplayer --next"
alias pprev "alsaplayer --prev"
alias volup "amixer set Master 5%+"
alias voldown "amixer set Master 5%-"
alias imv "/usr/bin/imv -s shrink"
alias mplayer "mplayer -dvd-device /dev/sr0"
alias lp2 "lp -o sides=two-sided-long-edge"
alias octal "stat -c '%a %n'"
alias rcopy "rclone copy -P"
alias rsync "rclone sync -P"
alias rls "rclone lsf"
alias rmount "rclone mount"
alias rcheck "rclone check -P"
alias gpg-public "gpg --export --armor"
alias gpg-private "gpg --export-secret-keys --armor"


function rtree
	set -l current_dir (pwd)
	rclone mkdir -P $argv[2]
	cd $argv[1]
		and find ./ -type d -exec rclone mkdir -P $argv[2]/{} \;
	cd $current_dir
end

function adbtree
	set -l current_dir (pwd)
	adb shell mkdir $argv[2]
	cd $argv[1]
		and find ./ -type d -exec adb shell mkdir $argv[2]/{} \;
	cd $current_dir
end

function vid2ogg
	set file $argv[1]
	set --local extension (echo $file | awk -F. '{print $NF}')
    set --local filename (basename $file .$extension)
	# -acodec libopus may be better
	ffmpeg -i $file -vn -acodec libvorbis $filename.ogg
end

function backup
	if test -d $XDG_DOCUMENTS_DIR/$argv[1]
		set -l before (du -sh $BUP_DIR | cut -f 1)
		bup index $XDG_DOCUMENTS_DIR/$argv[1]
		bup save -n (basename $argv[1]) $XDG_DOCUMENTS_DIR/$argv[1]
		set -l after (du -sh $BUP_DIR | cut -f 1)
		echo "$BUP_DIR: $before -> $after."
	else
		echo "$argv[1] not in $XDG_DOCUMENT_DIR/."
	end
end

function restore
	bup restore -C $HOME/bup $argv[1]/latest
end

function mailo
	if test -d $XDG_DOCUMENTS_DIR/$argv[1]
		backup $argv[1]
		rclone copy -P $XDG_DOCUMENTS_DIR/$argv[1] mailo:doc/$argv[1]
	else
		echo "$argv[1] not in $XDG_DOCUMENTS_DIR/."
	end
end


function bk --description "make a backup of a file"
	cp -a "$argv[1]" "$argv[1]"_(dater)
end

function lsl
	set -l filelist
	set -l timestamp 0
	set -l newest
	if test $argv[1]
		set filelist $argv[1]/*
	else
		set filelist *
	end
	for f in $filelist
		if test -f $f -a (stat -c '%Y' $f) -gt $timestamp
			set timestamp (stat -c '%Y' $f)
			set newest $f
		end
	end
	echo $newest
end

function mvif
	if test -e $argv[2]/$argv[1]
		mv $argv[1] $argv[2]
	end
end

function webcam --description "Use the webcam"
	echo modprobe uvcvideo
	echo mpv av://v4l2:/dev/video0
end


# get public ip
function myip --description 'Get my ip'
	set -l api
	switch "$1"
		case "-4"
			set api "http://v4.ipv6-test.com/api/myip.php"
			;;
		case "-6"
			set api "http://v6.ipv6-test.com/api/myip.php"
		case '*'
			set api "http://ipv6-test.com/api/myip.php"
	end
	curl -s "$api"
	echo # Newline.
	ip addr show | grep 'inet '
end

function urlencode
	python -c "import sys; from urllib.parse import quote_plus; print(quote_plus(sys.stdin.read()))"
end

function urldecode
	python -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()), end='')"
end

function node --description "Mount node desktop over ssh"
	if test -z "$argv"
		if not test -d $HOME/node
			mkdir $HOME/node
			sshfs $USER@192.168.1.82:/home/$USER $HOME/node -C -p 22
		end
	else
		fusermount3 -u $HOME/node
		rmdir $HOME/node
	end
end

# prompt
if string match --quiet --entire --regex "\(.+\)" (who -m)
	# login from ssh
	function fish_prompt --description 'write out the prompt'
		echo -n -s \
		(set_color brblack) "$USER" @ (prompt_hostname) \
		(set_color blue) ' ' (prompt_pwd) ' ' \
		(set_color brblack) "$status> " \
		(set_color normal)
	end
else
	# normal login
	function fish_prompt --description 'Write out the prompt'
		echo -n -s \
		(set_color brblack) "$USER" @ (prompt_hostname) \
		(set_color green) ' ' (prompt_pwd) ' ' \
		(set_color brblack) "$status> " \
		(set_color normal)
	end
end



# vi mode prompt 
function fish_default_mode_prompt --description 'Display the default mode for the prompt'
	if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color red
                echo 'N'
            case insert
                set_color green
                echo 'I'
            case replace_one
                set_color yellow
                echo 'R'
            case visual
                set_color magenta
                echo 'V'
        end
        set_color normal
        echo -n ' '
    end
end

# right prompt
set -l green (set_color green)
set -l magenta (set_color magenta)
set -l normal (set_color normal)
set -l red (set_color red)
set -l yellow (set_color yellow)
set -l black (set_color brblack)

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"

set __fish_git_prompt_color black --bold
set __fish_git_prompt_color_branch black --bold
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_invalidstate red --bold
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_untrackedfiles black --bold
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

function fish_right_prompt
	set last_status $status
	set_color brblack
	__fish_git_prompt
	set_color normal
end


# fish_default_key_bindings
fish_vi_key_bindings

#commands
# use systemctl enable --user mpd.socket or
# if test ! -s ~/.config/mpd/pid; mpd; end

if status --is-interactive
and test (tty) = /dev/tty1
	sway
end
