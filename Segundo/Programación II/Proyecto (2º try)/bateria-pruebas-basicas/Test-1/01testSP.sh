#!/bin/sh
#
# Autoevaluacion. Test 1
#
echo "MundoEncantado. Test 1"
java MundoEncantado -i 01instructionsSP.txt -o 01myoutputSP.txt
diff 01outputSP.txt 01myoutputSP.txt > 01result1SP.txt
cat 01result1SP.txt
diff 01playersoutSP.txt 01myplayersoutSP.txt > 01result2SP.txt
cat 01result2SP.txt
