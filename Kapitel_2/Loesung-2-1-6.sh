#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-6.sh
# 
#         USAGE: ./Loesung-2-1-6.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Your Name (), 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Ausgabe noch nicht komplett richtig
cat phone.book | column -t -s! | sort -k1 | grep -e "Hans" -e "Wolf" -w
