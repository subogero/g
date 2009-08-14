#!/bin/sh
##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the GNU GPL license
# There is absolutely no warranty.
##############################################################################

CMD=`which $1` 2>/dev/null
#echo Command found: $CMD
if   [ $# -eq 0    ]; then ################ No argument, open terminal #######
  #echo "TERMINAL"
  gnome-terminal;
elif [ "$1" = "-h" ]; then {
  #echo "HELP"
  echo 'Usage: go [-h] | [URL] | [command [options]]';
  echo;
  echo 'go           opens a new detached terminal window';
  echo 'go -h        shows usage (this text) and exits';
  echo 'go <URL>     opens URL with the preferred app in a new window';
  echo 'go <command> runs the command in a new window'
}
elif [ "$CMD" = "" ]; then ################ Argument is URL, open ############
  #echo "URL"; 
  gnome-open $1;
else                       ################ Argument is command ##############
  #echo COMMAND
  shift # Command parameters into $@
  # Detect GTK+ programs: Compiled        Python          Perl
  strings $CMD | grep -e 'libgtk-x11' -e 'import gtk' -e 'use Gtk2' >/dev/null 2>&1
  if [ $? -eq 0 ]; then    ################ Command uses GTK, start ##########
    $CMD $@ 2>/dev/null & disown 2>/dev/null;
  else                     ################ Command started in terminal ######
    gnome-terminal -e $CMD $@ >/dev/null 2>&1
  fi
fi
