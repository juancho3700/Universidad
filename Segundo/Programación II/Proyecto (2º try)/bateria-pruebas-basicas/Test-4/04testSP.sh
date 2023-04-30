#!/bin/sh
#
# Autoevaluacion. Test 4
#
echo "MundoEncantado. Test 4"
java MundoEncantado -i 04instructionsSP.txt -o 04myoutputSP.txt
diff 04outputSP.txt 04myoutputSP.txt > 04result1SP.txt
cat 04result1SP.txt
