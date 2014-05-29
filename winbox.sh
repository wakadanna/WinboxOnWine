#!/bin/bash
#
# Version: 0.2 [2013-Dec-30]
# Copyriht(C) 2013, Danna and RouterBoard User's Group JP
# Licensed under the Apache 2.0 License.
# 
# Installation:
# 1) $ chmod 755 winbox.sh
# 2) $ ln -s winbox.sh /usr/bin/winbox
#   or
#    $ mv winbox.sh /usr/bin/winbox
#
# Usage:
#  $ winbox [<connect-to> [<login> [<password>]]]
#  
#   It is possible to add command option to pass connect 
#  to user and password parameters automatically.
# 
#  For example (with no password);
#  $ winbox 192.168.88.1 admin ""
#

VERSION="0.2"
WINBOX="/opt/winbox"
WBLOG="/dev/null"

## Check:wine ##
WINE=`which wine`
if [ 0 != $? ]; then
   echo Error: wine command not exist.
   exit 1
fi

## Check:winbox.exe ##
if [ ! -f $WINBOX/winbox.exe ]; then
   echo Error: $WINBOX/winbox.exe not exist.
   exit 1
fi

## Check:Argument
if [ 0 -ne $# ]; then
   ## Display help
   if [ "-" = `echo $1 | cut -c 1` ]; then 
      if [ "--help" = "$1" ] || [ "-h" = "$1" ]; then
         echo
         echo "Version: $VERSION [" `wine --version` "]"
         echo
         cat <<EOF
Help:
  -h,--help   display this help and exit

Usage:
  $ winbox [<connect-to> [<login> [<password>]]]
  
   It is possible to add command option to pass connect to user and password parameters automatically.
 
  For example (with no password);
  $ winbox 192.168.88.1 admin ""

EOF
         exit 0
      else
         echo Error: Invalid argument.
         exit 1
      fi
   fi

   ## set: connect-to
   CONNECT="$1"
   ## SET: login user
   LOGIN="$2"
   ## SET: password
   PASSWD="$3"
fi

## start winbox ##
case $# in # num arguments
 "0" )
      $WINE $WINBOX/winbox.exe > $WBLOG 2>&1 & ;;
 "1" )
      $WINE $WINBOX/winbox.exe $CONNECT > $WBLOG 2>&1 & ;;
 "2" )
      $WINE $WINBOX/winbox.exe $CONNECT $LOGIN > $WBLOG 2>&1 & ;;
 "3" ) 
   if [ -n "$3" ]; then
      $WINE $WINBOX/winbox.exe $CONNECT $LOGIN $PASSWD > $WBLOG 2>&1 &
   else # with no password
      $WINE $WINBOX/winbox.exe $CONNECT $LOGIN "" > $WBLOG 2>&1 &
   fi ;;
esac

echo "Start: WinBox for wine (PID=$!) "

exit 0

