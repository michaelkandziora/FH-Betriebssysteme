#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-1.sh
# 
#         USAGE: ./
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.1
#		 
#		 Sortieren der Datei "phone.book" aufsteigend nach den Namen.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:52
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Datei Inhalt -> Tabelle(-t), Separator(-s!) -> Sortiere aufsteigend, 1. Spalte(-k1)
#-------------------------------------------------------------------------------
cat phone.book | sort -t! -k1 | column -t -s!
