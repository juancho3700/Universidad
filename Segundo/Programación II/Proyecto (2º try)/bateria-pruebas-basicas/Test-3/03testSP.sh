#!/bin/sh
#
# Autoevaluacion. Test 3
#
echo "MundoEncantado. Test 3"
java MundoEncantado -i 03instructionsSP.txt -o 03myoutputSP.txt
diff 03outputSP.txt 03myoutputSP.txt > 03result1SP.txt
cat 03result1SP.txt
