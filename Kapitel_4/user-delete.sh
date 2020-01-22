#!/bin/bash - 
#===============================================================================
#
#          FILE: user-delete.sh
# 
#         USAGE: ./user-delete.sh <user-added-YYYYMMDD-HHMMSS.txt>
# 
#   DESCRIPTION: Dieses Skript löscht die in der übergebenen Text-Datei 
#		 enthaltenen Benutzer inkl. ihrer Homeverzeichnisse.
#
#		 --- Exit-Codes ---
#		 1 - Skript wurde nicht als Root ausgeführt.
#		 2 - Parameter 1 ist keine Datei oder nicht lesbar.
#		 3 - Inhalt des Homeverzeichnisses konnte nicht gelöscht werden.
#		 4 - Benutzer konnte nicht gelöscht werden.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 15.11.2019 01:17
#      REVISION: ---
#==============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Prüfe ob das Skript als root ausgeführt wird
#-------------------------------------------------------------------------------
if [ $(id -u) != 0 ]
then 
	echo -e "\n\tDieses Skript muss als root ausgeführt werden.\n"
	exit 1
else
	echo -e "Du bist als root angemeldet."
fi


#-------------------------------------------------------------------------------
#	Prüfe ob die Eingabedatei eine Datei ist und lesbar ist
#-------------------------------------------------------------------------------
file="$1"

if [ ! -f "$file" ]
then
	echo -e "\n\t"$file" ist keine Datei oder nicht lesbar.\n"
	exit 2
fi

#-------------------------------------------------------------------------------
# Erstelle die Log-Datei für die zu löschenden Benutzer
#-------------------------------------------------------------------------------
date=`date +"%Y%m%d-%H%M%S"`
log_file=user-removed-$date.txt
touch $log_file

if [ $? == 0 ] 
then
  echo Log-Datei $log_file erfolgreich erstellt.
else
  echo -e "\n\tLog-Datei $log_file wurde nicht erstellt.\n"
  exit 3
fi

#-------------------------------------------------------------------------------
# Benutzer entfernen
#-------------------------------------------------------------------------------

# USER PARAMETER
u_count=0
u_loginname=""
#u_homedir=""
u_com=""

while read line; do
	
	# Login-Namen des zu löschenden Nutzers
	u_loginname="$(echo $line | cut -d: -f4 | tr "[A-Z]" "[a-z]")"
	
	# Homedir des zu löschenden Nutzers
	#u_homedir="$(echo $line | cut -d: -f3)"
	
	# Kommentar (Matrikelnummer) des zu erstellenden Nutzers
	u_com="$(echo $line | cut -d: -f3)"
	
	# Debug Ausgabe der Variablen für User u_xxx
	#printf "%s\n" $u_loginname
	
	# Prüfe ob der zu löschende Benutzer in der /etc/passwd Datei vorhanden ist
	egrep "^$u_loginname" /etc/passwd > /dev/null
	if  [ $? -eq 0 ];
	then
		# Lösche eventuell vorhandenen Inhalt im Homeverzeichnis des Benutzers
		#rm -r /home/fhswf/$u_homedir
		#if [ ! $? == 0 ] 
		#then
		#  echo -e "\n\t$u_loginname: Inhalt von $u_homedir konnte nicht gelöscht werden.\n"
		#  exit 3
		#fi
		
		# Lösche den Benutzer
		userdel -r "$u_loginname" >& /dev/null
		if [ $? == 0 ] 
		then
		  echo $u_loginname:$u_com >> $log_file
		  printf "\n\t%s erfolgreich gelöscht.\n" $u_loginname
		  ((u_count++))
		else
		  echo -e "\n\tBenutzer $u_loginname konnte nicht gelöscht werden.\n"
		  exit 4
		fi
	else
		echo -e "\n\tBenutzer "$u_loginname" existiert nicht.\n"
		continue
	fi
	
done < $file

printf "\n\t%d von %d Benutzer erfolgreich gelöscht\n" $u_count $(cat "$file" | wc -l)

#-------------------------------------------------------------------------------
# Aufräumen: Log-Datei löschen + Home-Verzeichnis (ParentNode) löschen
#-------------------------------------------------------------------------------
rmdir /home/fhswf
rm $file

