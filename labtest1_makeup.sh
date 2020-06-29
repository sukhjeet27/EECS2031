#!/bin/sh
#sukhjeet kaur
#216054272


if [ $# -lt 2 ]
then
    echo "You should enter the path name for course files and at least one command.
Use: lab3.sh path command [arg1 arg2 ...]
For the list of all commands use:
Example1: lab3.sh . h
For the list of number of registered students in each course use:
Example2: lab3.sh . creg"

fi


path=$1
files=`find $path -type f -name '*.rec' -perm /444`
if [ "C${files}" = "C" ]
then
    echo 'There is no readable *.rec file in the specified path or its subdirectories.'
fi

if [ $2 = 'h' ]
    then
        echo 'Here are defined commands:
creg: give the list of course names with the total number of students registered in each course.
stc ######: gives the name of all course names in which the student with ###### id registered in.
gpa ######: gives the GPA of the student defined with id ###### using the following formula: (course_1*credit_1 +   . . . + course_n*credit_n) / (credit_1+ . . . + credit_n)
cstats: Gives the course/student statistics.
h: prints the current message.'

elif [ $2 = 'creg' ]
    then
for course in $files
do
    read d1 d2 d3 name < $course
    credits=`grep -i "credits" $course | grep -o [0-9]`
    echo In "$name", "$credits" students register.
done
 
elif [ $2 = 'stc' ]
    then
input=$3
if [ ${#input} -ne 6 ]
then
    echo 'The student id should be 6 numbers.'
else
    count=0
    for course in $files
do
    grep -o "[0-9]\{6\}" $course >> temp
    while read line
do
    if [ $line = $input ]
        then
            if [ $count = '0' ]
            then
                echo The student with id: "$input", is registered in the following courses:
            fi
    read d1 d2 d3 name < $course
    credits=`grep -i "credits" $course | grep -o [0-9]`
    count=`expr $count + 1`
    echo -n $count." "
    name1=`echo $name | tr [:lower:] [:upper:]`
        echo $name1 "which has" $credits "credits"
    
fi
done < temp
rm temp
done
if [ $count = "0" ]
    then
        echo The student with id $input is not registered in any course.

    fi
fi
elif [ $2 = 'gpa' ]
then
input=$3
if [ ${#input} -ne 6 ]
then
	echo 'The student id should be 6 numbers.'
else

num_sum=0
den_sum=0
gp=0

for course in $files

do  
    sid=$(grep -o "$input" $course)
  # if [[ $sid -ne $input ]]
  
# then
#	   echo The student with id: $input is not registered in any course.
 #  fi
    grades=$(grep  "$input" $course | cut -c 3- | sed -e 's/^\s*//g' -e  's/\s*$//g' | cut -f2- -d" ")
    credits=$(grep -i "credits" $course | grep -o [0-9])
    for grade in $grades
    do
        num1=`expr  $grade \* $credits`
    
num_sum=`expr $num_sum + $num1`
done
den_sum=`expr $den_sum + $credits`
done
gp=$(( num_sum / $den_sum ))
echo "GPA for the student id:" $input is  $gp.
fi
 
elif [ $2 = 'csat' ]
 then
temp=__tmp
	echo -n "STUDENT#       "
	  for course in $files
do
    grep -o "[0-9]\{6\}" $course >> $temp
   # while read l
#do

    read d1 d2 d3 name < $course
   # credits=`grep -i "credits" $course | grep -o [0-9]`
   # count=`expr $count + 1`
  #  echo -n $count." "
 
    name1=`echo $name | tr [:lower:] [:upper:]`
    echo -n $name1 " "

done 
echo  "      " 
sort $temp | uniq
for c in $temp
do
	input=$c
num_sum=0
den_sum=0
for course in $files
    
do
      # set -x
    grades=$(grep  "$input" $course | cut -c 3- | sed -e 's/^\s*//g' -e  's/\s*$//g' | cut -f2- -d" ")
    #echo $grades
    credits=$(grep -i "credits" $course | grep -o [0-9])
    for grade in $grades
    do
        cr=`expr  $grade \* $credits`
       # echo $cr
    
num_sum=`expr $num_sum + $cr`

#echo $num_sum
done
den_sum=`expr $den_sum + $credits`
#echo $den_sum
done
gpa=$(( $num_sum / $den_sum ))
echo gpa is : $gpa

rm $temp
done
fi


