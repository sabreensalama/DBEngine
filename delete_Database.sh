#!/bin/bash
LC_ALL=C
shopt -s extglob

clear 
while true
do
echo "Enter Database Name you want delete!!!!!!!!!!!";
read database_name;
#validate if name of database is true ..
case $database_name in 
        #validate that the name must have not white spaces..
              
	*\ *)
            echo "-----------------------------------------------------------------------"; 
            echo "Invalid database name!! the name must be without no spaces..!! "
	  ;;
	#validate that the name must be letters only..
	+([[:digit:]])) 
            echo "-----------------------------------------------------------------------"; 
            echo "Invalid database name!! the name must be letters and do not have whitespaces!!!!!" 
          ;;
	#the valid regix for name..	
	+([a-zA-Z])) 
		#check if tha database exist...
	     source CheckIfDatabaseExist.sh ${database_name}
	      if [ $? -eq 0 ]
		then
                 #delete database..
                 rm -R $database_name;
                 echo "-----------------------------------------------------------------------"; 
	         echo "Database deleted!!!!!!!!!"
		  source DatabaseEngine.sh		
             else
                 echo "-----------------------------------------------------------------------"; 
                 echo "No database with this name!!!!!!!!!!"
             fi
                                                                                    ;;   
	*)
                 echo "-----------------------------------------------------------------------"; 
                 echo "Invalid database name!! name of database must be lower or upper letters or mix and do not have whitespaces!!!! "
esac
done
