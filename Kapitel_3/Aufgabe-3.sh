#!/bin/bash - 
#===============================================================================
#
#          FILE: Aufgabe-3.sh
# 
#         USAGE: ./Aufgabe-3.sh 
# 
#   DESCRIPTION: Dieses Skript führt die benötigten Befehle fuer das Aufgabenblatt 3 aus.
#		 Es beinhaltet nicht die Aufgabe 3.3.1 und alles ab 3.4 .
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 14.11.2019 10:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


	echo -e "\n\tAufgabe 3.1"
	echo -e "\n\t------------------\n"

	echo "BENUTZER STUDENT"
	printf "Gruppen: \t" && groups student
	printf "UID: \t" && id -u student
	printf "GID: \t" && id -g student
	echo -e "\n"

	echo "BENUTZER ROOT"
	printf "Gruppen: \t" && groups root
	printf "UID: \t" && id -u root
	printf "GID: \t" && id -g root
	echo -e "\n"

read -p "Weiter zu Aufgabe 3.2 ? [y]: " var
if [ $var!="y" ]
then
	echo -e "\n\tAufgabe 3.2"
	echo -e "\n\t------------------\n"
	read -p "ps aux | wc -l" 
	ps aux | wc -l	
	echo -e "\n"
	
	read -p "yes > /dev/null &"
	yes > /dev/null &
	echo -e "\n"
  
	read -p "ps | grep 'yes': "
	ps | grep 'yes'
	echo -e "\n"
	
	read -p "kill \$(pidof yes): "
	kill $(pidof yes)
	echo -e "\n"
	
	read -p "ps" && ps
	echo -e "\n"
fi

read -p "Weiter zu Aufgabe 3.3.2 ? [y]: " var
if [ $var!="y" ]
then
	echo -e "\n\tAufgabe 3.3.2"
	echo -e "\n\t------------------"

	mkdir ./3-3-2
	cd ./3-3-2
	touch jan{85..88} memo{1,10,2,2.sv} feb86 mar88 jan{5,12,19,26}.89 
	#touch feb86 jan12.89 jan19.89 jan26.89 jan5.89 jan85 jan86 jan87 jan88 mar88 memo1 memo10 memo2 memo2.sv
	echo -e "\n"
	
	read -p "echo *"
	echo *
	echo -e "\n"

	read -p "echo *[^0-9]"
	echo *[^0-9]
	echo -e "\n"

	read -p "echo m[a-df-z]*"
	echo m[a-df-z]*
	echo -e "\n"

	read -p "echo jan*"
	echo jan*
	echo -e "\n"

	read -p "echo *.*"
	echo *.*
	echo -e "\n"

	read -p "echo ?????"
	echo ?????
	echo -e "\n"

	read -p "echo *89"
	echo *89
	echo -e "\n"

	read -p "echo jan?? feb?? mar??"
	echo jan?? feb?? mar??
	echo -e "\n"

	read -p "echo [fjm][ae][bnr]*"
	echo [fjm][ae][bnr]*
	echo -e "\n"

	cd /home/student/BS/Kapitel_3 
fi

read -p "Weiter zu Aufgabe 3.3.3 ? [y]: " var
if [ $var!="y" ]
then
	echo -e "\n\tAufgabe 3.3.3"
	echo -e "\n\t------------------"

	mkdir ./3-3-3
	cd ./3-3-3
	echo -e "\n"

	read -p "touch 'stars*' stars1 stars2"
	touch "stars*" stars1 stars2
	echo -e "\n"

	read -p "touch ./-top"
	touch ./-top
	echo -e "\n"

	read -p "touch 'hello my friend'"
	touch "hello my friend"
	echo -e "\n"

	read -p "touch ''goodbye''"
	touch '"goodbye"'
	echo -e "\n"

	echo ""
	read -p "ls -l" && ls -l
	echo -e "\n"

	read -p "rm 'stars*' stars1 stars2"
	rm "stars*" stars1 stars2
	echo -e "\n"

	read -p "rm ./-top"
	rm ./-top
	echo -e "\n"

	read -p "rm 'hello my friend'"
	rm "hello my friend"
	echo -e "\n"

	read -p "rm ''goodbye''"
	rm '"goodbye"'
	echo -e "\n"

	echo ""
	read -p "ls -l" && ls -l
	echo -e "\n"

	cd /home/student/BS/Kapitel_3 
fi

read -p "Weiter zu Aufgabe 3.3.4 ? [y]: " var
if [ $var!="y" ]
then
	echo -e "\n\tAufgabe 3.3.4"
	echo -e "\n\t------------------"
	
	read -p "echo $LANG" && echo $LANG
	echo -e "\n"

	read -p "echo $LANG"
	#su -l root && echo $LANG
	echo -e "\n"

	mkdir ./3-3-4
	cd ./3-3-4

	read -p "touch a b c x y z A B C X Y Z ä ö ü Ä Ö Ü" && touch a b c x y z A B C X Y Z ä ö ü Ä Ö Ü
	echo -e "\n"
	
	echo "Ausgaben des Benutzers Student"
	echo -e "\n"
	
	read -p "echo *" && echo *
	echo -e "\n"
	
	read -p "echo [a-z]*" && echo [a-z]
	echo -e "\n"
	
	read -p "echo [A-Z]*" && echo [A-Z]
	echo -e "\n"
	
	read -p "find *" && find *
	echo -e "\n"
	
	echo "Ausgaben des Benutzers Root"
	echo -e "\n"
	
	read -p "echo *"
	#su -l root && echo *
	echo -e "\n"
	
	read -p "echo [a-z]*"
	#su -l root && echo [a-z]
	echo -e "\n"
	
	read -p "echo [A-Z]"
	#su -l root && echo [A-Z]
	echo -e "\n"
	
	read -p "sudo find *"
	#su -l root && find *
	echo -e "\n"

	cd /home/student/BS/Kapitel_3
fi

read -p "Weiter zu Aufgabe 3.3.5 ? [y]: " var
if [ $var!="y" ]
then
	echo -e "\n\tAufgabe 3.3.5"
	echo -e "\n\t------------------"

	read -p "cut -d: -s -f1 /etc/passwd | sort > benutzerliste.txt" 
	cut -d: -s -f1 /etc/passwd | sort > benutzerliste.txt
	echo -e "\n"

	read -p "cat benutzerliste.txt"
	cat benutzerliste.txt
	echo -e "\n"

	read -p "grep [*]* < /etc/passwd"
	grep [*]* < /etc/passwd
	echo -e "\n"

	read -p "grep [*]* /etc/passwd"
	grep [*]* /etc/passwd
	echo -e "\n"

	read -p "grep -n [*]* /etc/passwd | less"
	grep -n [*]* /etc/passwd | less

fi
	
echo -e "\n"
read -p "Aufraeumen ? [y]: " var
if [ $var!="y" ]
then
	rm -r ./3-3-2 ./3-3-3 ./3-3-4
fi



