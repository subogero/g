#!/bin/sh
##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the GNU GPL license
# There is absolutely no warranty.
##############################################################################

CMDFILE=`which $1` 2>/dev/null

### No argument, open terminal ###############################################
if   [ $# -eq 0    ]; then
  gnome-terminal;

### Display usage ############################################################
elif [ "$1" = "-h" ]; then
  echo 'Usage: go [-h] | [URL] | [command [options]]'
  echo
  echo 'go           opens a new detached terminal window'
  echo 'go -h        shows usage (this text) and exits'
  echo 'go <URL>     opens URL with the preferred app in a new window'
  echo 'go <command> runs the command in a new window';

### Argument is URL, open ####################################################
elif [ "$CMDFILE" = "" ]; then
  gnome-open $1;

### Argument is command ######################################################
else
  CMD=$1
  shift # Command parameters into $@

  # Detect X/GTK+ programs: Compiled X/GTK, Python, Perl
  strings $CMDFILE | grep -e 'libXaw3d'   \
                          -e 'libgtk-x11' \
                          -e 'import gtk' \
                          -e 'use Gtk2'   \
                          -e 'run-mozilla.sh' \
                          >/dev/null 2>&1

  ### Command uses GTK, start ################################################
  if [ $? -eq 0 ]; then
    $CMD $@ 2>/dev/null & disown 2>/dev/null;

  ### Command started in terminal ############################################
  else
    gnome-terminal -t $CMD -e $CMDFILE $@ >/dev/null 2>&1;
  fi;
fi
