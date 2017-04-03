#!/bin/bash

IFS=$'\n' read -d '' -r -a codes < returncodes
IFS=$'\n' read -d '' -r -a testname < testnames
IFS=$'\n' read -d '' -r -a param < params
IFS=$'\n' read -d '' -r -a testname2 < testnames2

TASK=xqr

if [ -f "xqr.php" ];
then
	INTERPRETER="php -d open_basedir=\"\""
	EXTENSION=php
elif [ -f "xqr.py" ];
then
	INTERPRETER="python3"
	EXTENSION=py
else
    echo "Error: xqr.php or xqr.py was not found."
	exit 1
fi

res=./out/
if [ ! -d "$res" ];
then
	mkdir "$res"
fi

#Copy the file to the TEST directory: Change this line to fit your needs
cp -vfu ../../$EXTENSION $EXTENSION

pwd=$(pwd)
mkdir "contains space"
cp -v in/test01.in "contains space/test 01.in"
cp -v queries/query1 "contains space/query 01"
#Test opening folder contains space
$INTERPRETER $TASK.$EXTENSION "--input=$pwd/contains space/test 01.in" "--output=$pwd/contains space/test 01.out" "--qf=$pwd/contains space/query 01" 2>/dev/null
returncode=$?
if [ $returncode -eq 0 ]; then
	echo -e "Folder/file with space[abs..path]: \e[32mPASS\e[39m"
else
	echo -e "Folder/file with space[abs..path]: \e[31mFAILED\e[39m"
fi

echo "Return code tests"

for i in {0..22}
do
	$INTERPRETER $TASK.$EXTENSION ${param[$i]} 1>/dev/null 2>/dev/null
	returncode=$?
	#check if returncode is the same as the expected
	echo -e "Test $i"
	if [ $returncode -eq "${codes[$i]}" ]; then
		echo -e "${testname[$i]} \e[32mPASS\e[39m"
	else
		echo -e "${testname[$i]} \e[31mFAILED\e[39m"
		echo "Return code: $returncode (expected: ${codes[$i]})"
		echo "Parameters : ${param[$i]}"
	fi
done


echo "Query tests"

for i in {1..23}
do
	if [ $i -eq 5 ];
	then
		echo -e "Test $i (stdin)"
		$INTERPRETER  $TASK.$EXTENSION --output="out/test$i.out" --qf="queries/query$i" --root="TEST" < "in/test01.in"
	elif [ $i -eq 6 ];
	then
		echo -e "Test $i (stdout)"
		$INTERPRETER  $TASK.$EXTENSION --input="in/test01.in" --qf="queries/query$i" --root="TEST" > "out/test$i.out"
	else
		echo -e "Test $i"
		$INTERPRETER  $TASK.$EXTENSION --input="in/test01.in" --output="out/test$i.out" --qf="queries/query$i" --root="TEST"
	fi
	returncode=$?
	if [ ! -f "out/test$i.out" ];
	then
		echo -e "\e[31mFile out/test$i.out does not exists\e[39m"
		echo "Parameters : ${param[$i]}"
		continue
	elif [ $returncode -eq 0 ]; then
		echo -e "${testname2[$i-1]} \e[32mPASS\e[39m"
		output=$(java -jar ./jexamxml/jexamxml.jar "out/test$i.out" "ref-out/test$i.out" delta.xml ./jexamxml/xqr_options)
		echo -e "Comparing out/test$i.out with ref-out/test$i.out"
		if [[ $string == *"not"* ]];
		then
  			echo -e "\e[31mTwo files are not identical\e[39m"
		else
			echo -e "\e[32mTwo files are identical\e[39m"
		fi

	else
		echo -e "${testname2[$i-1]} \e[31mFAILED\e[39m"
		echo "Return code: $returncode (expected: 0)"
		echo "Parameters : ${param[$i]}"
	fi
done

rm -r "contains space"
