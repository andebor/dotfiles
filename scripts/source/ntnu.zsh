function ntnu () {
    ssh andebor@$STUD "ldapsearch -h at.ntnu.no -x uid=$1" | grep 'cn: ' | cut -d " " -f 2- | head -1 
  }
