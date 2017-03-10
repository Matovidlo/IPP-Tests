#!/usr/bin/env bash

# Komplexnejsie testy CHA

TASK=cha
if [ -f "cha.php" ];
then
	INTERPRETER="php -d open_basedir=\"\""
	EXTENSION=php
elif [ -f "cha.py" ];
then
	INTERPRETER="python3"
	EXTENSION=py
else
    echo "Error: cha.php or cha.py was not found."
	exit 1
fi

res=./Results/
if [ ! -d "$res" ];
then
	mkdir "$res"
fi

# test01: Test parametru --help (nekontroluje sa vystup na stdout)
$INTERPRETER $TASK.$EXTENSION --help > ./Results/test01.out 2> ./Results/test01.err
echo -n $? > ./Results/test01.!!!

# test02: Test parametru --help s inym parametrom
$INTERPRETER $TASK.$EXTENSION --help --output=Tests/nonexistent/file > ./Results/test02.out 2> ./Results/test02.err
echo -n $? > ./Results/test02.!!!

# test03: Test parametru --help s inym parametrom
$INTERPRETER $TASK.$EXTENSION --pretty-xml --help > ./Results/test03.out 2> ./Results/test03.err
echo -n $? > ./Results/test03.!!!

# test04: Test parametru --help (kontroluje sa vypis na stdout)
$INTERPRETER $TASK.$EXTENSION --help > ./Results/test04.out 2> ./Results/test04.err
echo -n $? > ./Results/test04.!!!

# test05: Test na empty file
$INTERPRETER $TASK.$EXTENSION --input=./Tests/empty.h > ./Results/test05.out 2> ./Results/test05.err
echo -n $? > ./Results/test05.!!!

# test06: Missing output parameter (output goes to stdout)
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h > ./Results/test06.out 2> ./Results/test06.err
echo -n $? > ./Results/test06.!!!

# test07: Trivial file with a single function and nothing else
$INTERPRETER $TASK.$EXTENSION --input=./Tests/single.h > ./Results/test07.out 2> ./Results/test07.err
echo -n $? > ./Results/test07.!!!

# test08: File with comments containing diacritic
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h > ./Results/test08.out 2> ./Results/test08.err
echo -n $? > ./Results/test08.!!!

# test09: Function name contains underscores
$INTERPRETER $TASK.$EXTENSION --input=./Tests/underscore.h > ./Results/test09.out 2> ./Results/test09.err
echo -n $? > ./Results/test09.!!!

# test10: Input is a directory
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir > ./Results/test10.out 2> ./Results/test10.err
echo -n $? > ./Results/test10.!!!

# test11: Output is a directory
$INTERPRETER $TASK.$EXTENSION --output=./Tests/subdir/subsubdir > ./Results/test11.out 2> ./Results/test11.err
echo -n $? > ./Results/test11.!!!

# test12: --pretty-xml without k
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h --pretty-xml > ./Results/test12.out 2> ./Results/test12.err
echo -n $? > ./Results/test12.!!!

# test13: --pretty-xml=0
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h --pretty-xml=0 > ./Results/test13.out 2> ./Results/test13.err
echo -n $? > ./Results/test13.!!!

# test14: --pretty-xml=10
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h --pretty-xml=10 > ./Results/test14.out 2> ./Results/test14.err
echo -n $? > ./Results/test14.!!!

# test15: --no-inline
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/whitespace.h --no-inline > ./Results/test15.out 2> ./Results/test15.err
echo -n $? > ./Results/test15.!!!

# test16: --no-inline and --max-par=1
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/whitespace.h --no-inline --max-par=1 > ./Results/test16.out 2> ./Results/test16.err
echo -n $? > ./Results/test16.!!!

# test17: --max-par=0
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h --max-par=0 > ./Results/test17.out 2> ./Results/test17.err
echo -n $? > ./Results/test17.!!!

# test18: --max-par=2
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h --max-par=2 > ./Results/test18.out 2> ./Results/test18.err
echo -n $? > ./Results/test18.!!!

# test19: --no-duplicates
$INTERPRETER $TASK.$EXTENSION --input=./Tests/more.h --no-duplicates > ./Results/test19.out 2> ./Results/test19.err
echo -n $? > ./Results/test19.!!!

# test20: --no-duplicates and --max-par=1 and --no-inline
$INTERPRETER $TASK.$EXTENSION --input=./Tests/more.h --no-duplicates --max-par=1 --no-inline > ./Results/test20.out 2> ./Results/test20.err
echo -n $? > ./Results/test20.!!!

# test21: Preserve whitespace between types
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/whitespace.h > ./Results/test21.out 2> ./Results/test21.err
echo -n $? > ./Results/test21.!!!

# test22: --remove-whitespace
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/whitespace.h --remove-whitespace > ./Results/test22.out 2> ./Results/test22.err
echo -n $? > ./Results/test22.!!!

# test23: Ignore function declarations in comments
$INTERPRETER $TASK.$EXTENSION --input=./Tests/comments.h > ./Results/test23.out 2> ./Results/test23.err
echo -n $? > ./Results/test23.!!!

# test24: Comments in strings and strings in comments
$INTERPRETER $TASK.$EXTENSION --input=./Tests/str_comm.h > ./Results/test24.out 2> ./Results/test24.err
echo -n $? > ./Results/test24.!!!

# test25: Ignore function declarations in strings
$INTERPRETER $TASK.$EXTENSION --input=./Tests/strings.h.c > ./Results/test25.out 2> ./Results/test25.err
echo -n $? > ./Results/test25.!!!

# test26: Ignore function declarations in macros
$INTERPRETER $TASK.$EXTENSION --input=./Tests/macros.h > ./Results/test26.out 2> ./Results/test26.err
echo -n $? > ./Results/test26.!!!

# test27: Invalid parameter
$INTERPRETER $TASK.$EXTENSION --unknown-param > ./Results/test27.out 2> ./Results/test27.err
echo -n $? > ./Results/test27.!!!

# test28: Multiple occurrences of --input=
$INTERPRETER $TASK.$EXTENSION --input=./Tests/macros.h --input=./Tests/macros.h > ./Results/test28.out 2> ./Results/test28.err
echo -n $? > ./Results/test28.!!!

# test29: Multiple occurrences of --output=
$INTERPRETER $TASK.$EXTENSION --output=./Tests/out1 --output=./Tests/out2 > ./Results/test29.out 2> ./Results/test29.err
echo -n $? > ./Results/test29.!!!

# test30: Multiple occurrences of --pretty-xml=
$INTERPRETER $TASK.$EXTENSION --pretty-xml --pretty-xml=4 > ./Results/test30.out 2> ./Results/test30.err
echo -n $? > ./Results/test30.!!!

# test31: Multiple occurrences of --no-inline
$INTERPRETER $TASK.$EXTENSION --no-inline --no-inline > ./Results/test31.out 2> ./Results/test31.err
echo -n $? > ./Results/test31.!!!

# test32: Multiple occurrences of --max-par=
$INTERPRETER $TASK.$EXTENSION --max-par=5 --max-par=4 > ./Results/test32.out 2> ./Results/test32.err
echo -n $? > ./Results/test32.!!!

# test33: Multiple occurrences of --no-duplicates
$INTERPRETER $TASK.$EXTENSION --no-duplicates --no-duplicates > ./Results/test33.out 2> ./Results/test33.err
echo -n $? > ./Results/test33.!!!

# test34: Multiple occurrences of --remove-whitespace
$INTERPRETER $TASK.$EXTENSION --remove-whitespace --remove-whitespace > ./Results/test34.out 2> ./Results/test34.err
echo -n $? > ./Results/test34.!!!

# test35: Missing n after --max-par=
$INTERPRETER $TASK.$EXTENSION --max-par= > ./Results/test35.out 2> ./Results/test35.err
echo -n $? > ./Results/test35.!!!

# test36: Invalid n (NAN) after --max-par=
$INTERPRETER $TASK.$EXTENSION --max-par=4hh > ./Results/test36.out 2> ./Results/test36.err
echo -n $? > ./Results/test36.!!!

# test37: Invalid k (NAN) after --pretty-xml=
$INTERPRETER $TASK.$EXTENSION --pretty-xml=hh5 > ./Results/test37.out 2> ./Results/test37.err
echo -n $? > ./Results/test37.!!!

# test38: Non-existing input file
$INTERPRETER $TASK.$EXTENSION --input=/path/to/a/hopefully/nonexistent/file > ./Results/test38.out 2> ./Results/test38.err
echo -n $? > ./Results/test38.!!!

# test39: Unopenable input file
$INTERPRETER $TASK.$EXTENSION --input=/hopefully-no-write-permissions > ./Results/test39.out 2> ./Results/test39.err
echo -n $? > ./Results/test39.!!!

# test40: Unopenable output file
$INTERPRETER $TASK.$EXTENSION --output=/hopefully-no-write-permissions > ./Results/test40.out 2> ./Results/test40.err
echo -n $? > ./Results/test40.!!!

# test41: Input is a directory (whole dir) = STDIN
$INTERPRETER $TASK.$EXTENSION --pretty-xml > ./Results/test41.out 2> ./Results/test41.err
echo -n $? > ./Results/test41.!!!

# test42: Input is a directory (whole dir)
$INTERPRETER $TASK.$EXTENSION --pretty-xml > ./Results/test42.out 2> ./Results/test42.err
echo -n $? > ./Results/test42.!!!

# test43: Output file
$INTERPRETER $TASK.$EXTENSION --output=Results/test43.out --pretty-xml 2> ./Results/test43.err
echo -n $? > ./Results/test43.!!!

# test44: Input is .c file
$INTERPRETER $TASK.$EXTENSION --input=Tests/nothing.c --pretty-xml > ./Results/test44.out 2> ./Results/test44.err
echo -n $? > ./Results/test44.!!!

################################################################################
# Dalsi testy
# test 45: comments inside macro
$INTERPRETER $TASK.$EXTENSION --input=Tests/macro_comm.c --pretty-xml=4 > ./Results/test45.out 2> ./Results/test45.err
echo -n $? > ./Results/test45.!!!

# test 46: more comments
$INTERPRETER $TASK.$EXTENSION --input=Tests/comments2.c --pretty-xml=4 > ./Results/test46.out 2> ./Results/test46.err
echo -n $? > ./Results/test46.!!!

# test47: Ignore function declarations in strings
$INTERPRETER $TASK.$EXTENSION --input=./Tests/strings2.h.c > ./Results/test47.out > ./Results/test47.out 2> ./Results/test47.err
echo -n $? > ./Results/test47.!!!

# test48: Duplicated script parameters
$INTERPRETER $TASK.$EXTENSION --input=./Tests/strings2.h.c --input=Tests/comments2.c > ./Results/test48.out 2> ./Results/test48.err
echo -n $? > ./Results/test48.!!!

# test49: Multi line macros / comments
$INTERPRETER $TASK.$EXTENSION --input=./Tests/multi_line.h > ./Results/test49.out 2> ./Results/test49.err
echo -n $? > ./Results/test49.!!!

# test50: Function definition in function body
$INTERPRETER $TASK.$EXTENSION --input=./Tests/function_body.h > ./Results/test50.out 2> ./Results/test50.err
echo -n $? > ./Results/test50.!!!

# test51: No permissions to read file
chmod 000 ./Tests/restricted.h
$INTERPRETER $TASK.$EXTENSION --input=./Tests/restricted.h > ./Results/test51.out 2> ./Results/test51.err
echo -n $? > ./Results/test51.!!!

# test52: No permissions to read file when scanning dir
$INTERPRETER $TASK.$EXTENSION --input=./Tests > ./Results/test52.out 2> ./Results/test52.err
echo -n $? > ./Results/test52.!!!
chmod 664 ./Tests/restricted.h

# test53: Output file is dir
$INTERPRETER $TASK.$EXTENSION --input=./Tests > ./Results/test53.out --output=out/ 2> ./Results/test53.err
echo -n $? > ./Results/test53.!!!

# test54: Struct / enum / custom type in headers
$INTERPRETER $TASK.$EXTENSION --input=./Tests/struct_enum_params.h > ./Results/test54.out 2> ./Results/test54.err
echo -n $? > ./Results/test54.!!!

# test55: PAR / FUN extension tests
$INTERPRETER $TASK.$EXTENSION --input=./Tests/fun_par.h --pretty-xml=6 > ./Results/test55.out 2> ./Results/test55.err
echo -n $? > ./Results/test55.!!!

# test56: Support for shortened arguments
$INTERPRETER $TASK.$EXTENSION --input=./Tests/subdir/subsubdir/trivial.h > ./Results/test56.out 2> ./Results/test56.err
echo -n $? > ./Results/test56.!!!

# test57: Arguments duplication
$INTERPRETER $TASK.$EXTENSION --input=./Tests/struct_enum_params.h --input=./Tests/subdir/subsubdir/trivial.h > ./Results/test57.out 2> ./Results/test57.err
echo -n $? > ./Results/test57.!!!

# test58: Empty input value
$INTERPRETER $TASK.$EXTENSION --input= > ./Results/test58.out 2> ./Results/test58.err
ret=$(echo -n $?)
if [ "$ret" == "1" ]
then
    ret=2
fi
echo -n "$ret" > ./Results/test58.!!!

# test59: Empty output value
$INTERPRETER $TASK.$EXTENSION --output= > ./Results/test59.out 2> ./Results/test59.err
ret=$(echo -n $?)
if [ "$ret" == "1" ]
then
    ret=3
fi
echo -n "$ret" > ./Results/test59.!!!

# test60: Bad arguments, no value for input
$INTERPRETER $TASK.$EXTENSION --input > ./Results/test60.out 2> ./Results/test60.err
echo -n $? > ./Results/test60.!!!

# test61: Bad arguments, help with value
$INTERPRETER $TASK.$EXTENSION --help=ahoj > ./Results/test61.out 2> ./Results/test61.err
echo -n $? > ./Results/test61.!!!

# test62: Bad arguments, max-par with no value
$INTERPRETER $TASK.$EXTENSION --max-par= > ./Results/test62.out 2> ./Results/test62.err
echo -n $? > ./Results/test62.!!!

# test63: Bad arguments, max-par with no value
$INTERPRETER $TASK.$EXTENSION --max-par > ./Results/test63.out 2> ./Results/test63.err
echo -n $? > ./Results/test63.!!!

# test64: Special chars (diacritic, utf8 chars) in function or argument names
$INTERPRETER $TASK.$EXTENSION --input=./Tests/special_chars.h > ./Results/test64.out 2> ./Results/test64.err
echo -n $? > ./Results/test64.!!!

# test65: Underscores in function / arg names
$INTERPRETER $TASK.$EXTENSION --input=./Tests/more_underscores.h > ./Results/test65.out 2> ./Results/test65.err
echo -n $? > ./Results/test65.!!!

# test66: Missing -- in argument
$INTERPRETER $TASK.$EXTENSION input > ./Results/test66.out 2> ./Results/test66.err
echo -n $? > ./Results/test66.!!!

# test67: Bad integer value for pretty-xml
$INTERPRETER $TASK.$EXTENSION --pretty-xml=cislo --max-par=cislo > ./Results/test67.out 2> ./Results/test67.err
echo -n $? > ./Results/test67.!!!

# test68: Bad integer value for max-par
$INTERPRETER $TASK.$EXTENSION --max-par=cislo > ./Results/test68.out 2> ./Results/test68.err
echo -n $? > ./Results/test68.!!!

# test69: Function in comments / literals
$INTERPRETER $TASK.$EXTENSION --input=./Tests/comments_literals.h > ./Results/test69.out 2> ./Results/test69.err
echo -n $? > ./Results/test69.!!!

# test70: Structs / custom types in headers
$INTERPRETER $TASK.$EXTENSION --input=./Tests/structs_custom_types.h --pretty-xml > ./Results/test70.out 2> ./Results/test70.err
echo -n $? > ./Results/test70.!!!

# test71: Empty dir
$INTERPRETER $TASK.$EXTENSION --input=./Tests/emptydir > ./Results/test71.out 2> ./Results/test71.err
echo -n $? > ./Results/test71.!!!

# test72: PAR / FUN extension tests
$INTERPRETER $TASK.$EXTENSION --input=./Tests/fun_par.h --pretty-xml=6 --remove-whitespace > ./Results/test72.out 2> ./Results/test72.err
echo -n $? > ./Results/test72.!!!

# test73: Structs with PAR / FUN extension tests
$INTERPRETER $TASK.$EXTENSION --input=./Tests/struct_unnamed.h --pretty-xml=1 > ./Results/test73.out 2> ./Results/test73.err
echo -n $? > ./Results/test73.!!!
################################################################################


PASS="[ \033[0;32mOK\033[0;0m ]"
FAIL="[ \033[0;31mFAIL\033[0;0m ]"

printf "File\t Output\t Return code\n"

for i in 0{1..9} {10..73}
do
    printf "Test${i}\t "
    if [ $i == "01" ] || [ $i == "04" ] || [ $i == "52" ];
        then
            diff "Results/test${i}.out" "RefResults/test00.out" > /dev/null
            if [ $? == 0 ]; then printf "$FAIL"; else printf "$PASS"; fi;
        else
            diff "RefResults/test00.!!!" "RefResults/test${i}.!!!" > /dev/null
            if [ $? == 0 ];
                then
                    java -jar jexamxml/jexamxml.jar Results/test${i}.out RefResults/test${i}.out delta.xml cha_options >/dev/null
                    if [ $? == 0 ]; then printf "$PASS"; else printf "$FAIL"; fi;
                else
                    diff "Results/test${i}.out" "RefResults/test00.out" > /dev/null
                    if [ $? == 0 ]; then printf "$PASS"; else printf "$FAIL"; fi;
            fi;
    fi;
    diff "Results/test${i}.!!!" "RefResults/test${i}.!!!" > /dev/null
    code=$?
    printf "   ";
    if [ $code == 0 ]; then printf "$PASS"; else printf "$FAIL"; fi
	if [ $i == "51" ] || [ $i == "52" ]; then printf "\t(may need root)"; fi
    if [ $i == "41" ] || [ $i == "42" ] || [ $i == "43" ]; then printf "\t(checks ALL headers in CWD)"; fi
    if [ $i == "55" ] || [ $i == "72" ] || [ $i == "73" ]; then printf "\t(needs support for extensions)"; fi
	if [ $i == "56" ]; then printf "\t(needs support for shortened arguments)"; fi
    printf "\n"
done
