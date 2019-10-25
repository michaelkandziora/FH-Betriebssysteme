#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-2.sh
# 
#         USAGE: ./Loesung-2-1-2.sh 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.2
#
#		 Sortieren der Datei "phone.book" nach fallenden Telefonnummern.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:54
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Datei Inhalt -> Tabelle(-t), Separator(-s!) -> Sortiere Nummern(-n) absteigend(-r), 2. Spalte(-k2)
#-------------------------------------------------------------------------------
cat phone.book | sort -t! -k2 -n -r | column -t -s!
