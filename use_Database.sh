#!/bin/bash
LC_ALL=C
shopt -s extglob
function CheckIfDatabaseExist() {
	if [ -d "$database_name" ]; then
		return 0
	else
		return 1
	fi
}



while true
do

echo "Enter Database Name:"
read database_name
#validate if name of database is true ..
case $database_name in
#validate that the name must have not white spaces..

*\ *)
	echo "-----------------------------------------------------------------------"
	echo "Invalid database name!! the name must be without no spaces..!! "
	;;
	#validate that the name must be letters only..
+([[:digit:]]))
	echo "-----------------------------------------------------------------------"
	echo "Invalid database name!! the name must be letters and do not have whitespaces!!!!!"
	;;
	#the valid regix for name..
+([a-zA-Z]))
	#check if tha database created before ...
	if CheckIfDatabaseExist; then
             
		cd $database_name
                 break

                 
                
	else
		#if database does not exist..
		echo "-----------------------------------------------------------------------"
		echo "No database with this name!!!!!!!!!!"
                source $(pwd)/DatabaseEngine.sh

   
	fi
	;;

*) echo "Invalid database name!! name of database must be alphabtic " ;;
esac
done
