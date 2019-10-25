#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-2-1.sh
# 
#         USAGE: ./Loesung-2-2-1.sh 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.2.1
#
# 		 Bestimmen Sie die Anzahl der Studierenden in der
#		 Datei results.csv.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 14:36
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Inhalt der Datei -> Prüfe nach Gültigkeit -> Zähle Zeilen
#-------------------------------------------------------------------------------
cat results.csv | egrep "^[A-Z][0-9]{1,5},([A-Z -]+,){2}(C|F|D|HD|P|AF),[0-9]+(\.[0-9]{1,3})?,CA18$" | wc --lines
