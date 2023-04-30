#!/bin/sh
#
# Autoevaluacion. Test 5
#
echo "MundoEncantado. Test 5"
java MundoEncantado -j 05playersSP.txt -c 05creaturesSP.txt -r 05dealSP.txt -o 05mygameSP.txt
diff 05gameSP.txt 05mygameSP.txt > 05result1SP.txt
cat 05result1SP.txt
