#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-5.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.5
#
#		 Erstelle mit Hilfe von "ls" eine nach fallender Größe geordnete
#		 Liste aller Dateien im umfangreichsten Verzeichnis unterhalb von
 #		 "/usr". Zeigen Sie die Liste mit dem pager "less" an.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 15:48
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# -S sortiert absteigend nach Größe, -s gibt die Größe mit an.
#-------------------------------------------------------------------------------
ls -la --sort=size /usr/lib64 | egrep '^-' | less