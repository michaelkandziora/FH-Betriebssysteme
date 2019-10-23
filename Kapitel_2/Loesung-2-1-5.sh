#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-5.sh
# 
#         USAGE: ./Loesung-2-1-5.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Your Name (), 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:58
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cut -d! -f1 phone.book
