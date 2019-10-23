#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-3.sh
# 
#         USAGE: ./Loesung-2-1-3.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Your Name (), 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:56
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cat phone.book | column -t -s! | sort -k3
