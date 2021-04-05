#! /usr/bin/fish

source $argv[1]

sed -e "s/@bg_dark/$bg_dark/g; \
	s/@bg_light/$bg_light/g; \
	s/@bg_lighter/$bg_lighter/g; \
	s/@fg_dark/$fg_dark/g; \
	s/@fg_normal/$fg_normal/g; \
	s/@fg_light/$fg_light/g; \
	s/@red/$red/g; \
	s/@green/$green/g; \
	s/@yellow/$yellow/g; \
	s/@blue/$blue/g; \
	s/@magenta/$magenta/g; \
	s/@cyan/$cyan/g; \
	s/@light_red/$light_red/g; \
	s/@light_green/$light_green/g; \
	s/@light_yellow/$light_yellow/g; \
	s/@light_blue/$light_blue/g; \
	s/@light_magenta/$light_magenta/g; \
	s/@light_cyan/$light_cyan/g; \
	"

