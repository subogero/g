#!/bin/sh
##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the WTFPL license
##############################################################################
CMDFILE=`which $1` 2>/dev/null

### Which desktop environment is this? #######################################
for i in gnome-terminal mate-terminal konsole; do
  which $i >/dev/null 2>&1 && term=$i && break
done

for i in gnome-open mate-open kde-open; do
  which $i >/dev/null 2>&1 && open=$i && break
done

if [ -z "$term" -o -z "$open" ]; then
  echo Unknown desktop environment 1>&2
  exit 1
fi

### No argument, open terminal ###############################################
if [ $# -eq 0 ]; then
  $term;

### Display usage ############################################################
elif [ "$1" = "-h" ]; then
  echo 'Usage: g [-h] | [URL] | [command [options]]'
  echo
  echo 'g           opens a new detached terminal window'
  echo 'g -h        shows usage (this text) and exits'
  echo 'g -g <text> Google search for text in your preferred browser'
  echo 'g <URL>     opens URL with the preferred app in a new window'
  echo 'g <command> runs the command in a new window';

### Argument is Google search ################################################
elif [ "$1" = "-g" ]; then
  shift
  QUERY=""
  for WORD in "$@"; do
    QUERY="${QUERY}${WORD}+";
  done
  URL="http://www.google.com/search?q=${QUERY}"
  $open $URL

### Argument is URL, open ####################################################
elif [ "$CMDFILE" = "" ]; then
  $open "$@";

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
                          -e 'tkwait' \
                          -e 'MainLoop' \
                          -e 'mainloop' \
                          >/dev/null 2>&1

  ### Command seems to be X-program ##########################################
  if [ $? -eq 0 ]; then
    $CMD $@ 2>/dev/null & disown 2>/dev/null;

  ### Command seems to be terminal-program ###################################
  else
    $term -t $CMD -e $CMDFILE $@ >/dev/null 2>&1;
  fi;
fi
