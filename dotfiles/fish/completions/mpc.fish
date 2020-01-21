#! /usr/bin/fish

function __fish_mpc_needs_command
	set -l cmd (commandline -opc)
	if set -q cmd[2]
		return 1
	end
	return 0
end
	

function __fish_mpc_using_command
	set -l cmd (commandline -opc)
	test -z "$cmd[2]"
	and return 1
	contains -- $cmd[2] $argv
	and return 0
	return 1
end

complete -f -c mpc -n '__fish_mpc_needs_command' -a 'consume' -d 'Toggle consume mode'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'current' -d 'Show the currently playing song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'queued' -d 'Show the currently queued song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'next' -d 'Starts playing the next song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'pause' -d 'Pauses playing'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'play' -d 'Starts playing'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'pref' -d 'Starts playing the previous song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'random' -d 'Toggle random mode'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'repeat' -d 'Toggle repeat mode'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'single' -d 'Toggle single mode'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'seek' -d 'Seeks by hour, minutes, or seconds'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'stop' -d 'Stop playing'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'add' -d 'Adds a song to the queue'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'clear' -d 'Clear the queue'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'crop' -d 'Remove all song except the currently playing one'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'del' -d 'Removes a queue number from the queue'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'mv' -d 'Moves a song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'move' -d 'Moves a song'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'searchplay' -d 'Search the queue for a matching song and plays it'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'shuffle' -d 'Shuffles all song in the queue'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'ls' -d 'List files in the database'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'search' -d 'Search for substring in song tags'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'update' -d 'Scans for updated files in the music directory'
complete -f -c mpc -n '__fish_mpc_needs_command' -a 'rescans' -d 'Rescans the music directory'
complete -f -c mpc -n '__fish_mpc_using_command add' -a '(cd $XDG_MUSIC_DIR; and __fish_complete_path (commandline -ct))'
complete -f -c mpc -n '__fish_mpc_using_command insert' -a '(cd $XDG_MUSIC_DIR; and __fish_complete_path (commandline -ct))'
