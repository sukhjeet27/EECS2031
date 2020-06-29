#!/bin/sh 
#Sukhjeet kaur 216054272
#stc()
#{
#read fi
#echo -n $fi | wc -c
#}
#st()
#{ 
#enter="command1:"
#printf "enter: "
#read input
# tmp_file=__tmp
 # for course in $files
 # do
     
  # grep -o "[0-9]\{6\}" $course >> $tmp_file
  # apply sort and uniq on the content of the temporary file
 # if [ $input -eq $tmpfile ]
 # then
 # echo ' The student with id: $input, is registered in the following courses:'
 # read c1 c2 course_name < $course
 # cre=`grep "CREDITS:[[:space:]]* [0-9]" $course | grep -o [0-9]`
 # echo $course_name has $cre credits.
  
# rm $tmp_file
 
 # elif [ $input -ne $tmpfile ]
 # then
#	  echo 'The student with id: $input is not registered in any course.'
#fi
 # done
file=$1
#echo 'hello'
files=`find $file -type f -name '*.rec' -perm /444`

if [ "X${files}" = "X" ]
then
	echo 'There is no readable *.rec file in the specified path or its subdirectories.'
elif [ $# -lt 2 ] 	
#elif  [ -z "$1" ]
then
	echo 'You should enter the path name for course files and at least one command.
Use: lab3.sh path command [arg1 arg2 ...]
For the list of all commands use:
Example1: lab3.sh . h
For the list of number of registered students in each course use:
Example2: lab3.sh . creg'

elif [[ $2 == 'creg' ]]
 then 
	 echo 'hellocreg'
	 for course in $files
	 do
     read c1 c2 c3 name < $course
     ee="$(grep -o "[0-9]\{6\}" $course| wc -l)"
     echo 'In "'"$name"'"', "$ee" students register.
     done


elif [[ $2 == 'h' ]]
then 
	echo 'Here are defined commands: '
 	echo 'creg: give the list of course names with the total number of students registered in each course.'
 	echo 'stc ######: gives the name of all course names in which the student with ###### id registered in.'
 	echo 'gpa ######: gives the GPA of the student defined with id ###### using the following formula: (course_1*#credit_1 +course_n*credit_n) / (credit_1+ credit_n)'
 	echo 'h: prints the current message.'	break
   	echo 'You should enter the path name for course files and at least one command.
		Use: labtest1.sh path command [arg1 arg2 ...]
		For the list of all commands use:
		Example1: labtest1.sh . h
		For the list of number of registered students in each course use:
		Example2: labtest1.sh . creg'
elif [[ $2 == 'stc' ]]
	
then
	input=$3
	var=${#input} 
#set -x
if [ $var -ne 6 ] || [ $var -eq 0 ]  

	then
	echo "The student id should be 6 numbers."
else
	       count=0
	       for course in $files
	       do
		       grep -on "[0-9]\{6\}" $course >> temp
		while read line
		do
			if [ $line = $input ]
		then
			if [ $count = 0 ]
		then 
			echo "The student with this record doesn't exit"
		fi

read d1 d2 d3 name< $course
credits=`grep -i "credits" $course | grep -o [0-9]`
count=`expr $count + 1`
echo $count.  `echo $name  which has $credits credits`

fi
done < temp
rm temp
	       done
if [ $count = 0 ]
then
	echo 'the isjdjjdd'
fi
fi

       else
	 echo 'There is no readable *.rec file in the specified path or its subdirectories.'
 fi
 exit 0
