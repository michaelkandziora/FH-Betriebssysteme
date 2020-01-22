# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, .profile sources .bashrc - thus all settings
# made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# This might be helpful for Linux newbies who previously used DOS...
test -f /etc/profile.dos && . /etc/profile.dos

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

#
# Smart way of setting the DISPLAY variable (from Hans) :)
#
if test -z "$DISPLAY" -a "$TERM" = "xterm" -a -x /usr/bin/who ; then
    WHOAMI="`/usr/bin/who am i`"
    _DISPLAY="`expr "$WHOAMI" : '.*(\([^\.][^\.]*\).*)'`:0.0"
    if [ "${_DISPLAY}" != ":0:0.0" -a "${_DISPLAY}" != " :0.0" \
         -a "${_DISPLAY}" != ":0.0" ]; then
        export DISPLAY="${_DISPLAY}";
    fi
    unset WHOAMI _DISPLAY
fi

test -s ~/.alias && . ~/.alias

#-----------------------------------------------------------------------
#  trim directory
#-----------------------------------------------------------------------
export PROMPT_DIRTRIM=2

#-------------------------------------------------------------------------------
#  go to the last directory before the last logout
#-------------------------------------------------------------------------------
[ -s $HOME/.lastdirectory ] && cd $(cat $HOME/.lastdirectory)

#-------------------------------------------------------------------------------
#  Bash Directory Bookmarks
#-------------------------------------------------------------------------------
source $HOME/bin/bookmarks.sh 

#-------------------------------------------------------------------------------
#  Intel C-Compiler
#-------------------------------------------------------------------------------
#source /opt/intel/bin/compilervars.sh intel64

#-------------------------------------------------------------------------------
#  set XEDITOR
#-------------------------------------------------------------------------------
export	XEDITOR=gvim



