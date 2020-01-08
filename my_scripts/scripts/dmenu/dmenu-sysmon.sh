#!/bin/bash
#  ____ _____
# |  _ \_   _|  Derek Taylor (DistroTube)
# | | | || |    http://www.youtube.com/c/DistroTube
# | |_| || |    http://www.gitlab.com/dwt1/
# |____/ |_|
#
# Dmenu script for launching system monitoring programs.


declare -a options=("htop
glances
gtop
iftop
iotop
iptraf-ng
nmon
s-tui
quit")

choice=$(echo -e "${options[@]}" | dmenu -l -i -p 'System monitors: ')
terminal=$(which kitty)

case $choice in
	quit)
		echo "Program terminated." && exit 1
	;;
	htop| \
	glances| \
	gtop| \
	nmon| \
	s-tui)
        exec $terminal -e $choice
	;;
	iftop| \
	iotop| \
	iptraf-ng)
        exec $terminal -e pkexec $choice
	;;
	*)
		exit 1
	;;
esac

