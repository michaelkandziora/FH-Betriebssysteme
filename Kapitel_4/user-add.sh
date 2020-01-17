#!/bin/bash - 
#===============================================================================
#
#          FILE: user-add-2.sh
# 
#         USAGE: ./user-add-2.sh <user+num.txt>
# 
#   DESCRIPTION: Dieses Skript erstellt aus den in der übergebenen Text-Datei 
#		 enthaltenen Daten(Vorname,Nachname,Matr.Nr.) Benutzer 
#		 inkl. ihrer Homeverzeichnisse.
# 
#		 --- Exit-Codes ---
#		 1 - Skript wurde nicht als Root ausgeführt.
#		 2 - Parameter 1 ist keine Datei oder nicht lesbar.
#		 3 - Log-Datei konnte nicht erzeugt werden.
#		 4 - UID existiert bereits.
#		 5 - Benutzer konnte nicht erstellt werden.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 15.11.2019 00:01
#      REVISION:  ---
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
# Erstelle die Log-Datei für die zuerstellenden Benutzer
#-------------------------------------------------------------------------------
date=`date +"%Y%m%d-%H%M%S"`
log_file=user-added-$date.txt
touch $log_file
exit_code=$?

# Finde die zuletzt erzeugte Log-Datei
#log_file=$(find user-added-* | sort -r | head -1)

if [ $exit_code == 0 ] 
then
  echo Log-Datei "$log_file" erfolgreich erstellt.
else
  echo -e "\n\tLog-Datei "$log_file" wurde nicht erstellt. Code: $exit_code\n"
  exit 3
fi


#-------------------------------------------------------------------------------
# Benutzer anlegen
#-------------------------------------------------------------------------------

# DEFAULT PARAMETER
#D_GID=10
#D_COM="Kommentar"
#D_HOMEDIR="/home/fhswf/"

# USER PARAMETER
u_count=0
#u_uid=0
#u_gid=0
u_loginname=""
u_password=""
#u_homedir=""
u_com=""

# Erstelle default Home-Directory
#mkdir $D_HOMEDIR

while read vorname nachname matrikelnummer; do

	# Überprüfe die eingelesenen Parameter
	if [[ ! $vorname =~ ^[A-Za-z0-9]+$ ]]
	then
		echo -e "\n\t$vorname entspricht nicht den Anforderungen\n"
		exit 4
	fi
	
	# Überprüfe die eingelesenen Parameter
	if [[ ! $nachname =~ ^[A-Za-z0-9]+$ ]]
	then
		echo -e "\n\t$nachname entspricht nicht den Anforderungen\n"
		exit 4
	fi
	
	# Überprüfe die eingelesenen Parameter
	if [[ ! $matrikelnummer =~ ^[0-9]{8}$ ]]
	then
		echo -e "\n\t$matrikelnummer entspricht nicht den Anforderungen\n"
		exit 4
	fi
	
	# Erzeuge User-ID, durch entnehmen der höchsten UID (x<60.000) + Inkrementierung
	#u_uid=$(awk -F: '$3<60000 { print $3 }' /etc/passwd | sort -n | tail -1)
	#((u_uid++))
	
	# Prüfe ob UID bereits vorhanden ist
	#egrep "^$u_uid" /etc/passwd > /dev/null
	#exit_code=$?
	#if  [ $exit_code -eq 0 ]
	#then
	#	echo -e "\n\tUID existiert bereits. Code: $exit_code\n"
	#	exit 4
	#fi
	
	# Baue den Login-Namen des zu erstellenden Nutzers
	u_loginname="$(echo $nachname | tr "[A-Z]" "[a-z]")"
	
	# Erzeuge ein Random Passwort
	u_password=$(pwgen 8 1)
	
	# GROUP-ID
	#u_gid=${gid:-$D_GID}
	
	# Baue das Home-Directory des zu erstellenden Nutzers
	#u_homedir=${home:-$D_HOMEDIR${matrikelnummer}}
	
	# Kommentar
	#u_com=${com:-${matrikelnummer}}
	
	
	
	# Debug Ausgabe der Variablen für User u_xxx
	#printf "%d:\tLog: %s\tUid: %d\tGid: %d\tShell: %s\tCom: %s\thome-> %s\n" $u_count  $u_loginname $u_uid $u_gid $u_shell $u_com $u_homedir
	
	
	# Erstelle den Benutzer
	#useradd -u "$u_uid" -g "$u_gid" -c "$u_com" -d "$u_homedir" "$u_loginname"
	useradd -m -c $matrikelnummer "$u_loginname"
	
	exit_code=$?
	if [ $exit_code -eq 0 ] 
	then
	  echo -e "\n\t$u_loginname erfolgreich angelegt."
	  ((u_count++))
	  
	  # Erstelle HomeDir
	  #mkdir $u_homedir 
	  #chown $u_uid:$u_gid $u_homedir
	  
	  # Weise dem Benutzer das Passwort zu
	  echo ${u_loginname}:${u_password} | chpasswd 2>/dev/null
	  exit_code=$?
	  
	  if [ $exit_code -eq 0 ]
	  then
		echo -e "\tPasswort erfolgreich zugewiesen.\n"
	    
		# Speichere das Passwort in einer Datei
		# Format: Nachname Vorname Matrikelnummer Loginname Passwort
		echo $nachname:$vorname:$matrikelnummer:${u_loginname}:${u_password} >> $log_file
	  else
		echo -e "\tPasswort konnte nicht zugewiesen werden.\n"
	    
		# Speichere das Passwort in einer Datei
		# Format: Nachname Vorname Matrikelnummer Loginname Passwort
		echo $nachname:$vorname:$matrikelnummer:${u_loginname}:"Kein-Passwort" >> $log_file
	  fi
	else
	  echo -e "\n\tBenutzer konnte nicht erstellt werden. Code: $exit_code\n"
	  exit 5
	fi
	
done < $file


#-------------------------------------------------------------------------------
# Ausgabe: 
# Erfolgreiche Terminierung des Skripts inkl. der Anzahl der erstellten Benutzer
#-------------------------------------------------------------------------------
echo "$u_count" von $(cat "$file" | wc -l) Benutzer erfolgreich erstellt

