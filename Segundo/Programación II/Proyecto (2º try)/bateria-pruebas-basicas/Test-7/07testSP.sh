#!/bin/sh
#
# Autoevaluation. Test 7
#
echo "MundoEncantado. Test 7"
java MundoEncantado -i 07instructionsSP.txt -o 07myoutput1SP.txt
diff 07output1SP.txt 07myoutput1SP.txt > 07result1SP.txt
cat 07result1SP.txt
diff 07output2SP.txt 07myoutput2SP.txt > 07result2SP.txt
cat 07result2SP.txt
