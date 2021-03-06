#!/bin/bash
clear
new_arr=()	

source "functions";
source $(pwd)/use_Database.sh;

function get_check_line
{
  #must $ not have a space and ifs to separate files
  names=$(awk 'NR>3' "$filename")
  IFS=":" read -r -a all_arr <<< "$names"
  echo "$names"
 while true
do
  echo "enter the row you want to edit"
  read line

    if [[ "$line" =~ ^[1-9]+$ ]]
    then
        line=$((line+3))
        break
    elif [[ -z $line ]]
    then
       echo "must not be empty"
    elif [[ "$line" =~ ^[a-zA-Z]+$ ]]
    then
       echo "must be numeric "
     else
     echo "not valid"
     fi
done																				           
return $line
}



function get_data_of_table
{
get_check_line
line_ret=$?

 edit=$(sed -n "$line_ret p" "$filename")
IFS=":" read -r -a edit_arr <<< "$edit"
len="${#edit_arr[@]}"


for ((j=0;j<len;j++))
 do
	
  while true
  do

 echo "your old value is ${edit_arr[$j]}"
  echo "enter your new value : "
  read value
 
               	if [[ -z $value ]]
		       then
		        value=${edit_arr[$j]}
                      break
                    fi

   if [ ${col_types[$j]} = "number" ]
   then
   	   reg="^[0-9]+$"

	   if [[ "$value" =~ $reg ]]
	   then
	    check_pk "$value"
	    repeat="$?"
 

		    if [ "$repeat" -eq 1 ]
		    then
			  echo "repeated"
		    elif [  ! "$repeat" -eq 1 ]
		     then
		     echo "not repeated data"
		     new_arr+=("$value")
		     sed -i "$line s/${edit_arr[$j]}/$value/g" "$filename"
		       break

                else
                     echo "not valid"
		       
		   fi
          fi

   elif [ ${col_types[$j]} = "string" ]
	   then
	   reg="^[a-zA-Z]+$"
	   if [[ "$value" =~ $reg ]]
		   then
		   echo "you entered a valid value"
		   new_arr+=("$value")
		   sed -i "$line s/${edit_arr[$j]}/$value/g" "$filename"
		   break
           elif [[ -z $value ]]
             then
	     value=${edit_arr[$j]}
             break
    	  fi
         

   else
   echo "not valid, please enter a valid value"
   fi
done

  done
    echo "${new_arr[@]}"

  printf "\n"
					    echo "your record is edited "
																				  

}


while true
do
	echo "enter your file:"
	read filename


	if [[ -f "$filename" ]]
	then

	  get_structure_of_table
	  get_data_of_table
             for i in "${col_names[@]}"; do
		 printf '%s' "$i    |" 
	        done
                  printf "\n"
                   get_All_Data
          break
	else
	echo "your file does not exist"
fi
done

cd ..
source "DatabaseEngine.sh";
