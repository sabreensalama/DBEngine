#!/bin/bash
LC_ALL=C
function list_Databases() {
  echo
  echo "This Is All DataBases"
   echo "-----------------------------"
  for i in *; do
    if [ -d ./"$i" ]; then
      echo $i

      echo "--------------------------"

    fi

  done

}

list_Databases
cd /home/sabreensalama/Desktop/bash/project/DBEngine/
source /home/sabreensalama/Desktop/bash/project/DBEngine/DatabaseEngine.sh
