#!/bin/sh
#
# Autoevaluacion. Test 2
#
echo "MundoEncantado. Test 2"
java MundoEncantado -i 02instructionsSP.txt -o 02myoutputSP.txt
diff 02outputSP.txt 02myoutputSP.txt > 02result1SP.txt
cat 02result1SP.txt
diff 02creaturesoutSP.txt 02mycreaturesoutSP.txt > 02result2SP.txt
cat 02result2SP.txt
