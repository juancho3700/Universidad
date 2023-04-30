#!/bin/sh
#
# Autoevaluation. Test 6
#
echo "MundoEncantado. Test 6"
java MundoEncantado -i 06instructionsSP.txt -o 06myoutputSP.txt
diff 06outputSP.txt 06myoutputSP.txt > 06result1SP.txt
cat 06result1SP.txt
