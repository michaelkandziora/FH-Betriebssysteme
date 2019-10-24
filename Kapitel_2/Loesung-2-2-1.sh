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
# Befehl cat gibt den Inhalt der Datei aus. 
# Schalter -b gibt eine Zeilennummer für nicht leere Zeilen an.
#-------------------------------------------------------------------------------
cat -b results.csv
