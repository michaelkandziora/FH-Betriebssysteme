#!/bin/bash - 
#===============================================================================
#
#          FILE: user-add.sh
# 
#         USAGE: ./user-add.sh 
# 
#   DESCRIPTION: Dieses Skript erstellt user aus einer übergebenen Datei.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 14.11.2019 23:09
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Aufruf / Anzahl der Aufrufparameter überprüfen
#-------------------------------------------------------------------------------
if [ ${#} -lt 1 ]
then
	echo -e "\n\tAufruf: $0 Zu_Kopierende_Datei\n"
	exit 1
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu lesende Datei existiert
#-------------------------------------------------------------------------------
if [ ! -e "$1" ]
then
	echo -e "\n\t"$1" existiert nicht.\n"
	exit 2
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu lesende Datei eine Datei ist
#-------------------------------------------------------------------------------
if [ ! -f "$1" ]
then
	echo -e "\n\t"$1" ist keine Datei.\n"
	exit 3
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu lesende Datei lesbar ist
#-------------------------------------------------------------------------------
if [ ! -r "$1" ]
then
	echo -e "\n\t"$1" ist nicht lesbar.\n"
	exit 3
fi

#-------------------------------------------------------------------------------
# Unterverzeichnisse ermitteln
#-------------------------------------------------------------------------------
liste=$(cat $1)


#-------------------------------------------------------------------------------
# Kopieren 
#-------------------------------------------------------------------------------
zaehler=0


#  for element in $liste 
#  do 
    #if [ ! -d "$element" ] && [ ! -w "$element" ]
    #then
    #  echo -e "\n\t"$element" ist der aktuelle Nutzer.\n"
    #  exit 4
    #fi
    
#		echo $element
    #cp "$1" $element/"$1" && ((zaehler++))
#  done


	while read -a line; do

		#for (( i=1 ; i < ${#line}; i++ )); do
		#	echo "${line[i]}"
		#done
		
		echo ${line[0]} ${line[1]} ${line[2]}
	
	done < $1


#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Dateien erstellt\n"






