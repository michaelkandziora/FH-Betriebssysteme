#!/bin/bash - 
#===============================================================================
#
#          FILE: Aufgabe-5-6.sh
# 
#         USAGE: ./Aufgabe-5-6.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 12.12.2019 23:27
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Ausgabe Datei erstellen
#-------------------------------------------------------------------------------

file="report.txt"
touch $file
err_code=$?
if [ ! $err_code -eq 0 ]
then
	echo -e "\n\tDatei wurde nicht erzeugt. Error: $err_code\n"
fi


#-------------------------------------------------------------------------------
# 5.6.1 Verzeichnisse der GroeSse nach auflisten
#-------------------------------------------------------------------------------
echo -e "\n--- 5.6.1 Verzeichnisse der GroeSse nach auflisten ---\n" >> $file

du --one-file-system --max-depth=1 --min-depth=1 / | sort -r -n >> $file
#ls -lSh / | find -type d | head -15 >> $file


#-------------------------------------------------------------------------------
# 5.6.2 Dateien der GroeSse nach auflisten
#-------------------------------------------------------------------------------
echo -e "\n--- 5.6.2 Dateien der GroeSse nach auflisten ---\n" >> $file

ls -lSh /usr/bin | head -15 >> $file
#du /usr/bin | sort -r -n >> $file


#-------------------------------------------------------------------------------
# 5.6.3 Dateien ohne Besitzer auf diesem Rechner
#-------------------------------------------------------------------------------
echo -e "\n--- 5.6.3 Dateien ohne Besitzer auf diesem Rechner ---\n" >> $file

find / -mount -type f \( -nouser -o -nogroup \) -exec ls -lSha {} + | head -15 >> $file


#-------------------------------------------------------------------------------
# 5.6.4 Dateien mit Suid- oder Sgid-Bit
#-------------------------------------------------------------------------------
echo -e "\n--- 5.6.4 Dateien mit Suid- oder Sgid-Bit ---\n" >> $file

find / -mount \( -perm -4000 -o -perm -2000 \) -exec ls -lSha {} + | head -15 >> $file


#-------------------------------------------------------------------------------
# 5.6.5 Dateien mit allgemeinem Schreibzugriff
#-------------------------------------------------------------------------------
echo -e "\n--- 5.6.5 Dateien mit allgemeinem Schreibzugriff ---\n" >> $file

find / -mount \( -perm -002 \) -exec ls -lSha {} + | tail -15 >> $file



