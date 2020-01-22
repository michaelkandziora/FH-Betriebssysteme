#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-5.sh
# 
#         USAGE: ./
#
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.5
#
#		 Nur die erste Zeile der Datei "phone.book" ausgeben.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:58
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Head: Gebe die erste Zeile der Datei aus(-n1) -> Als Tabelle darstellen
#-------------------------------------------------------------------------------
head -n1 phone.book | column -t -s!
