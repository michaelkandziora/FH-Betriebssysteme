#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-1-4.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.4
#
#		 Alle Ausrufezeichen der Datei "phone.book" in Doppelpunkte umwandeln.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 15:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Inhalt der Datei ausgeben -> Wandle alle "!" in ":" um
#-------------------------------------------------------------------------------
cat phone.book | tr ! :

