#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-6.sh
# 
#         USAGE: ./Loesung-2-1-6.sh 
# 
#   DESCRIPTION: Bash-Lösung für 2.1.6:
#
#								 Nur Zeilen mit dem Namen "Hans" und "Wolf" aus der
#								 Datei "phone.book" ausgeben.
#								 Stellen Sie sicher,  dass genau diese beiden Namen 
#								 in der ersten Spalte gesucht werden. 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Ausgabe nicht richtig,  "Hans-Werner/Hans-Dieter" werden mit ausgegeben.
cat phone.book | column -t -s! | sort -k1 | grep -e "Hans" -e "Wolf" -w
