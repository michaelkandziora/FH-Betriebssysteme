#!/bin/bash - 
#===============================================================================
#
#          FILE: mehrfachloeschen.sh
# 
#         USAGE: ./mehrfachloeschen.sh 
# 
#   DESCRIPTION: Bash Tool, um eine als Parameter
#								 übergebene Datei aus allen Unterverzeichnisse
#								 des aktuellen Verzeichnisses zu loeschen.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 07.11.2019 17:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Aufruf / Anzahl der Aufrufparameter überprüfen
#-------------------------------------------------------------------------------
if [ ${#} -lt 1 ]
then
	echo -e "\n\tAufruf: $0 Zu_Loeschende_Datei\n"
	exit 1
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu loeschende Datei existiert
#-------------------------------------------------------------------------------
if [ ! -e "$1" ]
then
	echo -e "\n\t$1 existiert nicht.\n"
	exit 2
fi

#-------------------------------------------------------------------------------
# Unterverzeichnisse ermitteln
#-------------------------------------------------------------------------------
liste=$(find -type d -name "[^.]*")


#-------------------------------------------------------------------------------
# Kopieren 
#-------------------------------------------------------------------------------
zaehler=0

for element in $liste ; do rm $element/$1 && ((zaehler++)) ; done

#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Dateien entfernt\n"

